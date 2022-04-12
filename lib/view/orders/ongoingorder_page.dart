import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:java_code_app/constans/tools.dart';
import 'package:java_code_app/models/orderdetail.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/widget/appbar/appbar.dart';
import 'package:java_code_app/widget/list/listmenu_tile.dart';
import 'package:java_code_app/widget/list/listongoing_card.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class OngoingOrderPage extends StatefulWidget {
  final int id;

  const OngoingOrderPage({Key? key, required this.id}) : super(key: key);

  @override
  State<OngoingOrderPage> createState() => _OngoingOrderPageState();
}

class _OngoingOrderPageState extends State<OngoingOrderPage> {
  OrderDetail? data;
  int status = 0;
  bool _isLoading = false;

  getOrder() async {
    setState(() => _isLoading = true);
    data = await Provider.of<OrderProviders>(context, listen: false)
        .getDetailOrder(id: widget.id);
    if (data != null) status = data!.data.order.status;
    setState(() => _isLoading = false);
  }

  _cancelOrder() async {
    await showDialog(
        context: context,
        builder: (_) => ConfirmationDialog(
              onSubmit: () async {
                setState(() => _isLoading = true);
                if (data != null) {
                  final result =
                      await Provider.of<OrderProviders>(context, listen: false)
                          .cancelOrder(idOrder: data!.data.order.idOrder);
                  Provider.of<OrderProviders>(context, listen: false)
                      .getListOrder();
                  if (result) Navigator.pop(context);
                }
              },
            ));
    Navigator.pop(context);
  }

  @override
  void initState() {
    getOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSty.white,
      appBar: CostumeAppBar(
        back: true,
        title: 'Pesanan',
        icon: const Icon(IconsCs.pesanan, size: 28.0, color: ColorSty.primary),
        onDelete: status == 0 ? _cancelOrder : null,
      ),
      body: SingleChildScrollView(
        primary: true,
        child: Column(
          children: [
            if (data != null)
              Column(
                children: [
                  if (data!.data.detail
                      .where((e) => e.kategori == "makanan")
                      .isNotEmpty)
                    ListOrderOngoing(
                      detail: data!.data.detail,
                      title: 'Makanan',
                      type: 'makanan',
                    ),
                  if (data!.data.detail
                      .where((e) => e.kategori == "minuman")
                      .isNotEmpty)
                    ListOrderOngoing(
                      detail: data!.data.detail,
                      title: 'Minuman',
                      type: 'minuman',
                    ),
                ],
              ),
            const SizedBox(height: SpaceDims.sp24),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 380,
        decoration: const BoxDecoration(
            color: ColorSty.grey80,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            boxShadow: [
              BoxShadow(
                  color: ColorSty.grey60,
                  offset: Offset(0, -1),
                  spreadRadius: 1,
                  blurRadius: 1)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: SpaceDims.sp24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: SpaceDims.sp24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Total Pesanan ",
                              style: TypoSty.captionSemiBold,
                            ),
                            if (data != null)
                              Text("(${data?.data.detail.length} Menu) :",
                                  style: TypoSty.caption)
                            else
                              Skeleton(height: 16.0, width: 20),
                          ],
                        ),
                        if (data != null)
                          totalPesanan()
                        else
                          Skeleton(height: 16.0, width: 50),
                      ],
                    ),
                  ),
                  const SizedBox(height: SpaceDims.sp14),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SpaceDims.sp24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TileListDMenu(
                          dense: true,
                          prefixIcon: true,
                          title: data?.data.order.namaVoucher != null
                              ? "Voucher"
                              : "Diskon",
                          prefixCostume: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                  "Rp ${oCcy.format(data?.data.order.potongan)}",
                                  style: TypoSty.captionSemiBold.copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.red),
                                  textAlign: TextAlign.right),
                              Text(
                                data?.data.order.namaVoucher != null
                                    ? "${data?.data.order.namaVoucher}"
                                    : "${data?.data.order.diskon}%",
                                style: TypoSty.mini,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                              )
                            ],
                          ),
                          isLoading: _isLoading,
                          iconSvg: data?.data.order.namaVoucher != null
                              ? SvgPicture.asset(
                                  "assert/image/icons/voucher-icon.svg")
                              : SvgPicture.asset(
                                  "assert/image/icons/la_coins.svg"),
                          onPressed: () {},
                        ),
                        Stack(children: [
                          TileListDMenu(
                            dense: true,
                            title: "Pembayaran",
                            prefix: "Pay Later",
                            icon: IconsCs.coins,
                            isLoading: _isLoading,
                            onPressed: () {},
                          ),
                        ]),
                        TileListDMenu(
                          dense: true,
                          title: "Total Pembayaran",
                          prefix: "${data?.data.order.totalBayar}",
                          textStylePrefix: TypoSty.titlePrimary,
                          icon: Icons.wine_bar,
                          isLoading: _isLoading,
                          onPressed: () {},
                        ),
                        const SizedBox(height: SpaceDims.sp18),
                        Text(
                          "Pesanan kamu sedang disiapkan",
                          style: TypoSty.title,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: SpaceDims.sp14,
                            right: SpaceDims.sp14,
                            top: SpaceDims.sp24,
                            bottom: SpaceDims.sp8,
                          ),
                          child: Row(
                            children: [
                              if (status == 1)
                                const Icon(
                                  Icons.check_circle,
                                  color: ColorSty.primary,
                                )
                              else
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 10,
                                    width: 10,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: ColorSty.grey,
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(width: SpaceDims.sp8),
                              const Expanded(child: Divider(thickness: 2)),
                              const SizedBox(width: SpaceDims.sp8),
                              if (status == 2)
                                const Icon(
                                  Icons.check_circle,
                                  color: ColorSty.primary,
                                )
                              else
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 10,
                                    width: 10,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: ColorSty.grey,
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(width: SpaceDims.sp8),
                              const Expanded(child: Divider(thickness: 2)),
                              const SizedBox(width: SpaceDims.sp8),
                              if (status == 3)
                                const Icon(
                                  Icons.check_circle,
                                  color: ColorSty.primary,
                                )
                              else
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 10,
                                    width: 10,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: ColorSty.grey,
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(width: SpaceDims.sp8),
                            ],
                          ),
                        ),
                        Row(
                          children: const [
                            SizedBox(
                              width: 80,
                              child: Text("Pesanan diterima"),
                            ),
                            Expanded(child: Divider(color: Colors.transparent)),
                            SizedBox(
                              width: 80,
                              child: Text(
                                "Silahkan Ambil",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(child: Divider(color: Colors.transparent)),
                            SizedBox(
                              width: 80,
                              child: Text(
                                "Pesanan Selesai",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget totalPesanan() {
    var totalPesanan = 0;
    for (var i = 0; i < data!.data.detail.length; i++) {
      totalPesanan += data!.data.detail[i].total;
    }
    return Text(
      "Rp ${oCcy.format(totalPesanan)}",
      style: TypoSty.subtitle.copyWith(
        color: ColorSty.primary,
      ),
    );
  }
}

class ConfirmationDialog extends StatefulWidget {
  final VoidCallback? onSubmit;
  const ConfirmationDialog({Key? key, this.onSubmit}) : super(key: key);

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: SizedBox(
        height: 340,
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.delete_outline, size: 124.0),
                Text("Batal", style: TypoSty.heading),
                const SizedBox(height: SpaceDims.sp12),
                Text(
                  "Anda yakin ingin membatalkan pesanan ini?",
                  textAlign: TextAlign.center,
                  style: TypoSty.title.copyWith(
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: SpaceDims.sp12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0))),
                      onPressed: () => Navigator.pop(context),
                      child: const SizedBox(
                        width: 90,
                        child: Text("Tidak", textAlign: TextAlign.center),
                      ),
                    ),
                    const SizedBox(width: SpaceDims.sp12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: ColorSty.white,
                          onPrimary: Colors.red,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(30.0))),
                      onPressed: () {
                        setState(() => _isLoading = true);
                        if (widget.onSubmit != null) widget.onSubmit!();
                        // if(mounted) setState(() => _isLoading = false);
                      },
                      child: const SizedBox(
                        width: 90,
                        child: Text("Ya", textAlign: TextAlign.center),
                      ),
                    ),
                  ],
                )
              ],
            ),
            if (_isLoading)
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: ColorSty.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(30.0)),
                child: const RefreshProgressIndicator(),
              )
          ],
        ),
      ),
    );
  }
}
