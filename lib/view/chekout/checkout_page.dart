import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:java_code_app/constans/tools.dart';
import 'package:java_code_app/constans/try_api.dart';
import 'package:java_code_app/models/listvoucher.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/shadows.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/view/chekout/widget/list_order_checkout.dart';
import 'package:java_code_app/widget/appbar/appbar.dart';
import 'package:java_code_app/widget/dialog/custom_dialog.dart';
import 'package:java_code_app/widget/dialog/orderdone_dialog.dart';
import 'package:java_code_app/widget/dialog/vp_fingerprint_dialog.dart';
import 'package:java_code_app/widget/list/listmenu_tile.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  var cekVoucher = [];
  LVoucher? _selectedVoucher;
  int totalDiscout = 0,
      totalOrders = 0,
      totalPay = 0,
      totalDisP = 0,
      numOrders = 0;

  static final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final bool _loading = false;
  Future<void> _onRefresh() async {
    var _duration = const Duration(seconds: 1);
    if (mounted) {
      await _getData();

      Timer(_duration, () {
        _refreshController.refreshCompleted();
      });
    }
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    bool isAnyConnection = await checkConnection();
    if (isAnyConnection) {
      await Provider.of<OrderProviders>(context, listen: false)
          .getListVoucher(context);
      cekVoucher =
          Provider.of<OrderProviders>(context, listen: false).listVoucher;
      // print('cek cekVoucher:${cekVoucher.length} ');
      await Provider.of<OrderProviders>(context, listen: false)
          .getListDisCount(context);
      final _orders =
          Provider.of<OrderProviders>(context, listen: false).checkOrder;
      final _discount =
          Provider.of<OrderProviders>(context, listen: false).listDiscount;
      totalDiscout = _discount.isNotEmpty
          ? _discount.map((e) => e.diskon).reduce((a, b) => a + b)
          : totalDiscout;

      totalOrders =
          _orders.values.map((e) => e["harga"]).reduce((a, b) => a + b);

      totalDisP = (totalOrders * (totalDiscout / 100)).toInt();
      totalPay = totalOrders - totalDisP;
      numOrders = _orders.length;
    } else {
      Provider.of<OrderProviders>(context, listen: false).setNetworkError(
        true,
        context: context,
        title: 'Koneksi anda terputus',
        then: () => _getData(),
      );
    }
  }

  void _checkOut() {
    final _orders =
        Provider.of<OrderProviders>(context, listen: false).checkOrder;
    final _discount =
        Provider.of<OrderProviders>(context, listen: false).listDiscount;
    showDialog(
      context: context,
      builder: (_) => VFingerPrintDialog(
        onSubmit: (bool value) async {
          if (value) {
            Provider.of<OrderProviders>(context, listen: false).sendCheckOut(
              context,
              idVoucher: _selectedVoucher?.idVoucher,
              idDiscount: _discount.map((e) => e.idDiskon).toList(),
              discount: totalDiscout,
              totalPotong: totalDisP,
              totalPay: totalPay,
              totalOrder: totalOrders,
              menu: _orders.values
                  .map((e) => {
                        "id_menu": e["id"],
                        "harga": e["harga"],
                        "level": e["level"],
                        "topping": e["topping"],
                        "jumlah": e["countOrder"],
                        "catatan": e["catatan"]
                      })
                  .toList(),
            );

            if (value) {
              await Provider.of<OrderProviders>(context, listen: false)
                  .clearCheckout();
              Navigator.pop(context);
              await showDialog(
                context: context,
                builder: (_) => const OrderDoneDialog(),
              );
            }
          }
        },
      ),
    );
  }

  void _setVoucher() async {
    try {
      final data = await Navigate.toSelectionVoucherPage(
        context,
        initialData: _selectedVoucher,
      );

      if (mounted) {
        setState(() {
          _selectedVoucher = data;
          if (data != null) {
            totalPay = totalOrders - (data as LVoucher).nominal;
            if (totalPay < 0) totalPay = 0;
          }
        });
      }
    } catch (e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: OrderProviders(),
      builder: (_, __) {
        final _orders = Provider.of<OrderProviders>(context).checkOrder;
        final _discount = Provider.of<OrderProviders>(context).listDiscount;

        if (_discount.isNotEmpty) {
          totalDiscout = _discount.map((e) => e.diskon).reduce((a, b) => a + b);
        }

        if (_orders.isNotEmpty) {
          totalOrders = _orders.values
              .map((e) => e["harga"] * e["countOrder"])
              .reduce((a, b) => a + b);
          totalDisP = (totalOrders * (totalDiscout / 100)).toInt();
          if (_selectedVoucher == null) totalPay = totalOrders - totalDisP;
          numOrders = _orders.length;
        }

        final isMin = _orders.values
            .where((element) => element["jenis"] == "minuman")
            .isNotEmpty;
        final isMak = _orders.values
            .where((element) => element["jenis"] == "makanan")
            .isNotEmpty;
        final isSnack = _orders.values
            .where((element) => element["jenis"] == "snack")
            .isNotEmpty;

        return Scaffold(
          appBar: const CostumeAppBar(
            back: true,
            icon: Icon(IconsCs.pesanan, size: 28.0, color: ColorSty.primary),
            title: 'Pesanan',
          ),
          body: SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              primary: true,
              child: Column(
                children: [
                  Column(
                    children: [
                      if (isMak)
                        ListOrder(
                          orders: _orders,
                          title: 'Makanan',
                          type: 'makanan',
                        ),
                      if (isMin)
                        ListOrder(
                          orders: _orders,
                          title: 'Minuman',
                          type: 'minuman',
                        ),
                      if (isSnack)
                        ListOrder(
                          orders: _orders,
                          title: 'Snack',
                          type: 'snack',
                        ),
                    ],
                  ),
                  const SizedBox(height: SpaceDims.sp24),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            width: double.infinity,
            // height: _selectedVoucher == null ? 300 : 240,
            decoration: const BoxDecoration(
              color: ColorSty.grey80,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: SpaceDims.sp24,
                        // vertical: SpaceDims.sp14,
                      ),
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Total Pesanan ",
                                  style: TypoSty.captionSemiBold,
                                ),
                                _loading
                                    ? const SizedBox(
                                        width: 30,
                                        child: SkeletonText(height: 18.0))
                                    : Text("($numOrders Menu) :",
                                        style: TypoSty.caption),
                              ],
                            ),
                            _loading
                                ? const SizedBox(
                                    width: 100,
                                    child: SkeletonText(height: 18.0))
                                : Text(
                                    "Rp ${oCcy.format(totalOrders)}",
                                    style: TypoSty.subtitle.copyWith(
                                      color: ColorSty.primary,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        if (_selectedVoucher == null)
                          TileListDMenu(
                            dense: true,
                            prefixIcon: true,
                            title: "Diskon $totalDiscout%",
                            prefix: "Rp ${oCcy.format(totalDisP)}",
                            textStylePrefix: const TextStyle(color: Colors.red),
                            iconSvg: SvgPicture.asset(
                              "assert/image/icons/discount-icon.svg",
                              height: 22.0,
                            ),
                            onPressed: () => showDiskonDialog(),
                            // showDialog(
                            //   context: context,
                            //   builder: (_) => const InfoDiscountDialog(),
                            // ),
                            isLoading: _loading,
                          ),
                        if (cekVoucher.isNotEmpty)
                          TileListDMenu(
                            dense: true,
                            prefixIcon: true,
                            title: "Voucher",
                            prefixCostume: _selectedVoucher == null
                                ? null
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Rp ${oCcy.format(_selectedVoucher!.nominal)}",
                                        style: TypoSty.captionSemiBold
                                            .copyWith(color: Colors.red),
                                      ),
                                      Text(
                                        _selectedVoucher!.nama,
                                        style: TypoSty.mini,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.end,
                                      )
                                    ],
                                  ),
                            prefix: _selectedVoucher == null
                                ? "Pilih Voucher"
                                : null,
                            // icon: IconsCs.voucher,
                            iconSvg: SvgPicture.asset(
                              "assert/image/icons/voucher-icon-line.svg",
                            ),
                            onPressed: _setVoucher,
                            isLoading: _loading,
                          ),
                        TileListDMenu(
                          dense: true,
                          isLoading: _loading,
                          title: "Pembayaran",
                          prefix: "Pay Later",
                          // icon: IconsCs.coins,
                          iconSvg: SvgPicture.asset(
                            "assert/image/icons/la_coins.svg",
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 60.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorSty.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    boxShadow: ShadowsB.boxShadow4,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SpaceDims.sp20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              IconsCs.shopingbag,
                              color: ColorSty.primary,
                            ),
                            SizedBox(width: SpaceDims.sp14.w),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Total Pembayaran",
                                  style: TextStyle(color: ColorSty.black60),
                                ),
                                Text(
                                  "Rp ${oCcy.format(totalPay)}",
                                  style: TypoSty.titlePrimary,
                                ),
                              ],
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: _checkOut,
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                            ),
                          ),
                          child: Text(
                            "Pesan Sekarang",
                            style: TypoSty.button,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  showDiskonDialog() {
    final _discount =
        Provider.of<OrderProviders>(context, listen: false).listDiscount;
    showCustomDialog(
      context,
      body: _discount.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Anda tidak memiliki diskon.',
                  style: TypoSty.caption,
                ),
              ),
            )
          : Column(
              children: [
                const SizedBox(height: SpaceDims.sp24),
                Text("Info Discount", style: TypoSty.titlePrimary),
                Column(
                  children: [
                    const SizedBox(height: SpaceDims.sp24),
                    for (final item in _discount) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item.nama, style: TypoSty.caption),
                          Text("${item.diskon} %", style: TypoSty.captionBold),
                        ],
                      ),
                      const SizedBox(height: SpaceDims.sp4),
                    ],
                  ],
                ),
              ],
            ),
      labelYes: 'Oke',
      onYes: () => Navigator.of(context).pop(),
    );
  }
}
