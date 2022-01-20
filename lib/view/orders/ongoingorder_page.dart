import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:java_code_app/models/orderdetail.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/widget/listmenu_tile.dart';
import 'package:java_code_app/widget/listongoing_card.dart';
import 'package:java_code_app/widget/silver_appbar.dart';
import 'package:provider/provider.dart';

class OngoingOrderPage extends StatefulWidget {
  final int id;
  const OngoingOrderPage({Key? key, required this.id}) : super(key: key);

  @override
  State<OngoingOrderPage> createState() => _OngoingOrderPageState();
}

class _OngoingOrderPageState extends State<OngoingOrderPage> {
  OrderDetail? data;
  int status = 0;
  getOrder() async {
    data = await Provider.of<OrderProviders>(context, listen: false).getDetailOrder(id: widget.id);
    if(data != null) status = data!.data.order.status;
    setState(() {});
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
      body: SilverAppBar(
        back: true,
        pinned: true,
        floating: true,
        title: Row(
          children: [
            const Icon(IconsCs.pesanan, size: 28.0),
            const SizedBox(width: SpaceDims.sp8),
            Text("Pesanan", style: TypoSty.title),
            const SizedBox(width: SpaceDims.sp8),
          ],
        ),
        body: SingleChildScrollView(
          primary: true,
          child: Column(
            children: [
              if(data != null)
                Column(
                children: [
                  if (data!.data.detail.where((e) => e.kategori == "makanan").isNotEmpty)
                    ListOrderOngoing(
                      detail: data!.data.detail,
                      title: 'Makanan',
                      type: 'makanan',
                    ),
                  if (data!.data.detail.where((e) => e.kategori == "minuman").isNotEmpty)
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
              blurRadius: 1
            )
          ]
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
                            Text("(${data?.data.detail.length} Menu) :", style: TypoSty.caption),
                          ],
                        ),
                        Text(
                          "Rp ${data?.data.order.totalBayar}",
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TileListDMenu(
                          dense: true,
                          prefixIcon: true,
                          title: data?.data.order.namaVoucher != null ? "Voucher" : "Diskon",
                          prefixCostume: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Rp ${data?.data.order.potongan}", style: TypoSty.captionSemiBold.copyWith(fontWeight: FontWeight.normal, color: Colors.red), textAlign: TextAlign.right),
                              Text(
                                data?.data.order.namaVoucher != null
                                    ? "${data?.data.order.namaVoucher}"
                                    : "${data?.data.order.diskon}%",
                                style: TypoSty.mini,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,)
                            ],
                          ),
                          iconSvg: data?.data.order.namaVoucher != null
                              ? SvgPicture.asset("assert/image/icons/voucher-icon.svg")
                              : SvgPicture.asset("assert/image/icons/la_coins.svg"),
                          onPressed: () {},
                        ),
                        Stack(children: [
                          TileListDMenu(
                            dense: true,
                            title: "Pembayaran",
                            prefix: "Pay Leter",
                            icon: IconsCs.coins,
                            onPressed: () {},
                          ),
                        ]),
                        TileListDMenu(
                          dense: true,
                          title: "Total Pembayaran",
                          prefix: "Rp 4.000",
                          textStylePrefix: TypoSty.titlePrimary,
                          icon: Icons.wine_bar,
                          onPressed: (){},
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
                              if(status == 1)
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
                              if(status == 2)
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
                                ),const SizedBox(width: SpaceDims.sp8),
                              const Expanded(child: Divider(thickness: 2)),
                              const SizedBox(width: SpaceDims.sp8),
                              if(status == 3)
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
}
