import 'package:flutter/material.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/thame/colors.dart';
import 'package:java_code_app/thame/icons_cs_icons.dart';
import 'package:java_code_app/thame/shadows.dart';
import 'package:java_code_app/thame/spacing.dart';
import 'package:java_code_app/thame/text_style.dart';
import 'package:java_code_app/widget/infodiscount_dialog.dart';
import 'package:java_code_app/widget/listmenu_tile.dart';
import 'package:java_code_app/widget/menuberanda_card.dart';
import 'package:java_code_app/widget/silver_appbar.dart';
import 'package:java_code_app/widget/vp_fingerprint_dialog.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SilverAppBar(
        notScrolled: true,
        title: Row(
          children: [
            const Icon(IconsCs.pesanan, size: 28.0),
            const SizedBox(width: SpaceDims.sp8),
            Text("Pesanan", style: TypoSty.title),
            const SizedBox(width: SpaceDims.sp8),
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
                boxShadow: ShadowsB.boxShadow1,
              ),
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
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => VFingerPrintDialog(ctx: context));
                      },
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

class ListOrder extends StatelessWidget {
  final String type, title;

  const ListOrder({
    Key? key,
    required this.type,
    required this.title,
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
              Icon(
                type.compareTo("makanan") == 0
                    ? Icons.coffee
                    : IconsCs.ep_coffee,
                color: ColorSty.primary,
                size: 26.0,
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
              for (Map<String, dynamic> item in orders)
                if (item["jenis"]?.compareTo(type) == 0)
                  CardMenu(
                    onPressed: () => Navigate.toEditOrder(
                      context,
                      count: 1,
                      name: item["nama"] ?? "",
                      urlImage: item["image"] ?? "",
                      harga: item["harga"] ?? "",
                      amount: item["amount"] ?? 0,
                    ),
                    nama: item["nama"] ?? "",
                    url: item["image"] ?? "",
                    harga: item["harga"] ?? "",
                    amount: item["amount"] ?? 0,
                    count: 2,
                  ),
            ],
          ),
        ),
      ],
    );
  }
}

List<Map<String, dynamic>> orders = [
  {
    "jenis": "minuman",
    "image": "assert/image/menu/1637916759.png",
    "harga": "Rp 10.000",
    "nama": "Chicken Katsu",
    "amount": 99,
  },
  {
    "jenis": "makanan",
    "image": "assert/image/menu/1637916792.png",
    "harga": "Rp 10.000",
    "nama": "Chicken Katsu",
    "amount": 99,
  },
  {
    "jenis": "makanan",
    "image": "assert/image/menu/1637916829.png",
    "harga": "Rp 10.000",
    "nama": "Chicken Slam",
    "amount": 99,
  },
];
