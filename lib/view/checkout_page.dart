import 'package:flutter/material.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/thame/colors.dart';
import 'package:java_code_app/thame/icons_cs_icons.dart';
import 'package:java_code_app/thame/spacing.dart';
import 'package:java_code_app/thame/text_style.dart';
import 'package:java_code_app/view/beranda_page.dart';
import 'package:java_code_app/view/detailmenu_page.dart';
import 'package:java_code_app/widget/infodiscount_dialog.dart';
import 'package:java_code_app/widget/listmenut_tile.dart';
import 'package:java_code_app/widget/silver_appbar.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SilverAppBar(
        notScrolled: true,
        title: Row(
          children: const [
            Icon(IconsCs.pesanan, size: 28.0),
            SizedBox(width: SpaceDims.sp8),
            Text("Pesanan", style: TypoSty.title),
            SizedBox(width: SpaceDims.sp8),
          ],
        ),
        pinned: true,
        floating: true,
        body: SingleChildScrollView(
          primary: true,
          child: Column(
            children: [
              Column(
                children: const [
                  ListMenu(
                    title: 'Makanan',
                    type: 'makanan',
                  ),
                  ListMenu(
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
        height: 300,
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: SpaceDims.sp24),
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
                      children: [
                        TileListDMenu(
                          dense: true,
                          prefixIcon: true,
                          title: "Diskon 20%",
                          prefix: "Rp 4.000",
                          textStylePrefix: const TextStyle(color: Colors.red),
                          icon: Icons.wine_bar,
                          onPressed: () => showDialog(
                              context: context,
                              builder: (_) => const InfoDiscountDialog()),
                        ),
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
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, -0.9),
                      color: ColorSty.grey80.withOpacity(0.05),
                      spreadRadius: 10,
                    ),
                    BoxShadow(
                      offset: const Offset(0, -0.9),
                      color: ColorSty.grey80.withOpacity(0.05),
                      spreadRadius: 8,
                    ),
                    BoxShadow(
                      offset: const Offset(0, -0.9),
                      color: ColorSty.grey80.withOpacity(0.1),
                      spreadRadius: 7,
                    ),
                    BoxShadow(
                      offset: const Offset(0, -0.9),
                      color: ColorSty.grey80.withOpacity(0.1),
                      spreadRadius: 3,
                    ),
                    BoxShadow(
                      offset: const Offset(0, -0.9),
                      color: ColorSty.grey80.withOpacity(0.1),
                      spreadRadius: 2,
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          IconsCs.shopingbag_icon,
                          color: ColorSty.primary,
                        ),
                        const SizedBox(width: SpaceDims.sp14),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Total Pembayaran",
                              style: TextStyle(color: ColorSty.black60),
                            ),
                            Text("Rp 27.000", style: TypoSty.titlePrimary),
                          ],
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                        ),
                      ),
                      child: const Text(
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
  }
}

