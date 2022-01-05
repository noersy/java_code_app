import 'package:flutter/material.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/thame/colors.dart';
import 'package:java_code_app/thame/icons_cs_icons.dart';
import 'package:java_code_app/thame/spacing.dart';
import 'package:java_code_app/thame/text_style.dart';
import 'package:java_code_app/view/checkout_page.dart';
import 'package:java_code_app/widget/infodiscount_dialog.dart';
import 'package:java_code_app/widget/listmenu_tile.dart';
import 'package:java_code_app/widget/silver_appbar.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

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
              Column(
                children: const [
                  ListOrder(
                    title: 'Makanan',
                    type: 'makanan',
                  ),
                  ListOrder(
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
                    padding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Text(
                              "Total Pesanan ",
                              style: TypoSty.captionSemiBold,
                            ),
                            Text("(3 Menu) :", style: TypoSty.caption),
                          ],
                        ),
                        Text(
                          "Rp 30.000",
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
                          title: "Voucher",
                          prefix: "Pilih Voucher",
                          icon: IconsCs.voucher_icon_line,
                          onPressed: () =>
                              Navigate.toSelectionVoucherPage(context),
                        ),
                        Stack(children: [
                          TileListDMenu(
                            dense: true,
                            title: "Pembayaran",
                            prefix: "Pay Leter",
                            icon: IconsCs.la_coins,
                            onPressed: () {},
                          ),
                        ]),
                        TileListDMenu(
                          dense: true,
                          title: "Total Pembayaran",
                          prefix: "Rp 4.000",
                          textStylePrefix: TypoSty.titlePrimary,
                          icon: Icons.wine_bar,
                          onPressed: () => showDialog(
                              context: context,
                              builder: (_) => const InfoDiscountDialog()),
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
                              const Icon(
                                Icons.check_circle,
                                color: ColorSty.primary,
                              ),
                              const SizedBox(width: SpaceDims.sp8),
                              const Expanded(child: Divider(thickness: 2)),
                              const SizedBox(width: SpaceDims.sp8),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 10,
                                  width: 10,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: ColorSty.grey,
                                      borderRadius: BorderRadius.circular(100.0),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: SpaceDims.sp8),
                              const Expanded(child: Divider(thickness: 2)),
                              const SizedBox(width: SpaceDims.sp8),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 10,
                                  width: 10,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: ColorSty.grey,
                                      borderRadius: BorderRadius.circular(100.0),
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
                              child: Text("Silahkan Ambil", textAlign: TextAlign.center),
                            ),
                            Expanded(child: Divider(color: Colors.transparent)),
                            SizedBox(
                              width: 80,
                              child: Text("Pesanan Selesai", textAlign: TextAlign.center),
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
