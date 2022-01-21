import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:java_code_app/constans/tools.dart';
import 'package:java_code_app/models/listvoucher.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/shadows.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/view/chekout/widget/card_menucheckout.dart';
import 'package:java_code_app/widget/appbar.dart';
import 'package:java_code_app/widget/infodiscount_dialog.dart';
import 'package:java_code_app/widget/listmenu_tile.dart';
import 'package:java_code_app/widget/orderdone_dialog.dart';
import 'package:java_code_app/widget/vp_fingerprint_dialog.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  LVoucher? _selectedVoucher;
  int totalDiscout = 0,
      totalOrders = 0,
      totalPay = 0,
      totalDisP = 0,
      numOrders = 0;

  static final RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool _loading = false;
  Future<void> _onRefresh() async {
    var _duration = const Duration(seconds:1);
    if (mounted) {
      setState(() => _loading = true);

      await _getData();

      Timer(_duration, () {
        setState(() => _loading = false);
        _refreshController.refreshCompleted();
      });
    }
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async{
    await Provider.of<OrderProviders>(context, listen: false).getListDisCount();
    final _orders = Provider.of<OrderProviders>(context, listen: false).checkOrder;
    final _discount = Provider.of<OrderProviders>(context, listen: false).listDiscount;
    totalDiscout = _discount.isNotEmpty
        ? _discount.map((e) => e.diskon).reduce((a, b) => a + b)
        : totalDiscout;

    totalOrders = _orders.values.map((e) => e["harga"]).reduce((a, b) => a + b);


    totalDisP = (totalOrders * (totalDiscout / 100)).toInt();
    totalPay = totalOrders - totalDisP;
    numOrders = _orders.length;
    if(mounted) setState(() {});
  }
  void _checkOut() {
    final _orders = Provider.of<OrderProviders>(context, listen: false).checkOrder;
    final _discount = Provider.of<OrderProviders>(context, listen: false).listDiscount;
    showDialog(
      context: context,
      builder: (_) => VFingerPrintDialog(
        onSumint: (bool value) async {
          if (value) {
            Provider.of<OrderProviders>(context, listen: false).sendCheckOut(
              idVoucher: _selectedVoucher?.idVoucher,
              idDiscount : _discount.map((e) => e.idDiskon).toList(),
              discount: totalDiscout,
              totalPotong: totalDisP,
              totalPay: totalPay,
              totalOrder: totalOrders,
              menu: _orders.values.map((e) => {
                "id_menu": e["id"],
                "harga": e["harga"],
                "level": e["level"],
                "topping": e["topping"],
                "jumlah": e["countOrder"],
                "catatan": e["catatan"]
              }).toList(),
            );

            // if(value) Navigator.pop(context);
            await showDialog(
              context: context,
              builder: (_) => const OrderDoneDialog(),
            );
          }
        },
      ),
    );
  }
  void _setVoucher() async {
    try{
      final data = await Navigate.toSelectionVoucherPage(
        context,
        initialData: _selectedVoucher,
      );

      if(mounted) {
        setState(() {
        _selectedVoucher = data;
        if (data != null) {
          totalPay = totalOrders - (data as LVoucher).nominal;
          print(data.nominal);
          if (totalPay < 0) totalPay = 0;
        }
      });
      }
    }catch(e){
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
            totalOrders = _orders.values.map((e) => e["harga"] * e["countOrder"])
                .reduce((a, b) => a + b);

            totalDisP = (totalOrders * (totalDiscout / 100)).toInt();
            if(_selectedVoucher == null) totalPay = totalOrders - totalDisP;
            numOrders = _orders.length;
          }

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
                        if (_orders.values
                            .where((element) => element["jenis"] == "makanan")
                            .isNotEmpty)
                          ListOrder(
                            orders: _orders,
                            title: 'Makanan',
                            type: 'makanan',
                          ),
                        if (_orders.values
                            .where((element) => element["jenis"] == "minuman")
                            .isNotEmpty)
                          ListOrder(
                            orders: _orders,
                            title: 'Minuman',
                            type: 'minuman',
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
              height: _selectedVoucher == null ? 300 : 240,
              decoration: const BoxDecoration(
                color: ColorSty.grey80,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: SpaceDims.sp24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SpaceDims.sp24.w,
                          ),
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
                                      ? const SizedBox(width: 30,child: SkeletonText(height: 18.0))
                                      : Text("($numOrders Menu) :",
                                      style: TypoSty.caption),
                                ],
                              ),
                              _loading
                                  ? const SizedBox(width: 100,child: SkeletonText(height: 18.0))
                                  : Text(
                                "Rp ${oCcy.format(totalOrders)}",
                                style: TypoSty.subtitle.copyWith(
                                  color: ColorSty.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: SpaceDims.sp14),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: SpaceDims.sp24,
                          ),
                          child: Column(
                            children: [
                              if (_selectedVoucher == null)
                                TileListDMenu(
                                  dense: true,
                                  prefixIcon: true,
                                  title: "Diskon $totalDiscout%",
                                  prefix: "Rp ${oCcy.format(totalDisP)}",
                                  textStylePrefix:
                                      const TextStyle(color: Colors.red),
                                  iconSvg: SvgPicture.asset(
                                      "assert/image/icons/discount-icon.svg",
                                      height: 24.0),
                                  onPressed: () => showDialog(
                                    context: context,
                                    builder: (_) => const InfoDiscountDialog(),
                                  ),
                                  isLoading: _loading,
                                ),
                              TileListDMenu(
                                dense: true,
                                prefixIcon: true,
                                title: "Voucher",
                                prefixCostume: _selectedVoucher == null
                                    ? null
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
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
                        )
                      ],
                    ),
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
                      boxShadow: ShadowsB.boxShadow1,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: SpaceDims.sp24.h),
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
        });
  }
}

class ListOrder extends StatelessWidget {
  final String type, title;
  final Map<String, dynamic> orders;

  const ListOrder({
    Key? key,
    required this.type,
    required this.title,
    required this.orders,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: SpaceDims.sp22),
        Padding(
          padding: const EdgeInsets.only(left: SpaceDims.sp24),
          child: Row(
            children: [
              type.compareTo("makanan") == 0
                  ? SvgPicture.asset(
                      "assert/image/icons/ep_food.svg",
                      height: 22,
                    )
                  : SvgPicture.asset(
                      "assert/image/icons/ep_coffee.svg",
                      height: 26,
                    ),
              const SizedBox(width: SpaceDims.sp4),
              Text(
                title,
                style: TypoSty.title.copyWith(
                  color: ColorSty.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: SpaceDims.sp12),
        SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              for (Map<String, dynamic> item in orders.values)
                if (item["jenis"]?.compareTo(type) == 0)
                  CardMenuCheckout(data: item),
            ],
          ),
        ),
      ],
    );
  }
}

class DeleteMenuInCheckoutDialog extends StatelessWidget {
  final String id;

  const DeleteMenuInCheckoutDialog({Key? key, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        child: SizedBox(
          height: 400,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 42),
            child: Column(
              children: [
                Stack(
                  children: [
                    SvgPicture.asset(
                      "assert/image/icons/img-pesanan-disiapkan.svg",
                    ),
                    Positioned(
                      top: 5,
                      left: 2,
                      child: Stack(
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                color: ColorSty.white,
                                borderRadius: BorderRadius.circular(100.0)),
                          ),
                          const Icon(Icons.cancel,
                              size: 42.0, color: Colors.redAccent)
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: SizedBox(
                    width: 200,
                    child: Column(
                      children: [
                        Text(
                          "Hapus Item?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 20.sp,
                          ),
                        ),
                        const SizedBox(height: SpaceDims.sp8),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Kamu akan mengeluarkan menu ini dari ',
                            style: TypoSty.caption2.copyWith(
                              fontWeight: FontWeight.normal,
                              fontSize: 16.0,
                            ),
                            children: const <TextSpan>[
                              TextSpan(
                                text: 'Pesanan',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: SpaceDims.sp12),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: ColorSty.white,
                                  onPrimary: ColorSty.primary,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: SpaceDims.sp8),
                                  shape: const RoundedRectangleBorder(
                                    side: BorderSide(color: ColorSty.primary),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Provider.of<OrderProviders>(context,
                                          listen: false)
                                      .deleteOrder(id: id);
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Oke"),
                              ),
                            ),
                            const SizedBox(width: SpaceDims.sp12),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: SpaceDims.sp8,
                                  ),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30.0),
                                    ),
                                  ),
                                ),
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Kembali"),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
