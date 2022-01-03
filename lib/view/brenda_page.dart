import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:java_code_app/thame/colors.dart';
import 'package:java_code_app/thame/icons_cs_icons.dart';
import 'package:java_code_app/thame/spacing.dart';
import 'package:java_code_app/thame/text_style.dart';
import 'package:java_code_app/widget/silver_appbar.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({Key? key}) : super(key: key);

  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  @override
  Widget build(BuildContext context) {
    return SilverAppBar(
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: SpaceDims.sp12),
        child: _search,
      ),
      floating: true,
      pinned: true,
      body: const ContentBeranda(),
    );
  }

  TextFormField get _search => TextFormField(
        decoration: InputDecoration(
          isDense: true,
          hintText: "Pencarian",
          icon: const Icon(
            Icons.search,
            size: 26.0,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: SpaceDims.sp12,
            horizontal: SpaceDims.sp16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorSty.primary, width: 2.0),
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      );
}

class ContentBeranda extends StatelessWidget {
  const ContentBeranda({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: SpaceDims.sp22),
          Padding(
            padding: const EdgeInsets.only(left: SpaceDims.sp24),
            child: Row(
              children: [
                const Icon(
                  IconsCs.coupon,
                  color: ColorSty.primary,
                  size: 22.0,
                ),
                const SizedBox(width: SpaceDims.sp22),
                Text("Promo yang Tersedia",
                    style: TypoSty.title.copyWith(color: ColorSty.primary)),
              ],
            ),
          ),
          const SizedBox(height: SpaceDims.sp22),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: const [
                SizedBox(width: 10),
                CardCoupon(),
                CardCoupon(),
                CardCoupon(),
              ],
            ),
          ),
          const SizedBox(height: SpaceDims.sp22),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: const [
                SizedBox(width: SpaceDims.sp12),
                LabelButton(
                  title: "Semua Menu",
                  icon: Icons.list,
                ),
                LabelButton(
                  title: "Makanan",
                  icon: Icons.coffee,
                ),
                LabelButton(
                  title: "Minum",
                  icon: Icons.wine_bar,
                ),
              ],
            ),
          ),
          const SizedBox(height: SpaceDims.sp22),
          Padding(
            padding: const EdgeInsets.only(left: SpaceDims.sp24),
            child: Row(
              children: [
                const Icon(
                  Icons.coffee,
                  color: ColorSty.primary,
                  size: 32.0,
                ),
                const SizedBox(width: SpaceDims.sp22),
                Text("Makanan",
                    style: TypoSty.title.copyWith(color: ColorSty.primary)),
              ],
            ),
          ),
          const SizedBox(height: SpaceDims.sp12),
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                for (Map<String, dynamic> item in datafake)
                  if (item["jenis"]?.compareTo("makanan") == 0)
                    CardMakananBeranda(
                      nama: item["nama"] ?? "",
                      url: item["image"] ?? "",
                      harga: item["harga"] ?? "",
                      amount: item["amount"] ?? 0,
                    ),
              ],
            ),
          ),
          const SizedBox(height: SpaceDims.sp22),
          Padding(
            padding: const EdgeInsets.only(left: SpaceDims.sp24),
            child: Row(
              children: [
                const Icon(
                  Icons.wine_bar,
                  color: ColorSty.primary,
                  size: 32.0,
                ),
                const SizedBox(width: SpaceDims.sp22),
                Text("Minuman",
                    style: TypoSty.title.copyWith(color: ColorSty.primary)),
              ],
            ),
          ),
          const SizedBox(height: SpaceDims.sp12),
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                for (Map<String, dynamic> item in datafake)
                  if (item["jenis"]?.compareTo("minuman") == 0)
                    CardMakananBeranda(
                      nama: item["nama"] ?? "",
                      url: item["image"] ?? "",
                      harga: item["harga"] ?? "",
                      amount: item["amount"] ?? 0,
                    ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CardMakananBeranda extends StatefulWidget {
  final String nama, harga, url;
  final int amount;

  const CardMakananBeranda({
    Key? key,
    required this.nama,
    required this.harga,
    required this.url,
    required this.amount,
  }) : super(key: key);

  @override
  State<CardMakananBeranda> createState() => _CardMakananBerandaState();
}

class _CardMakananBerandaState extends State<CardMakananBeranda> {
  int jumlahOrder = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp12),
      child: Card(
        color: ColorSty.white60,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Container(
              height: 74,
              width: 74,
              margin: const EdgeInsets.all(SpaceDims.sp8),
              child: Padding(
                padding: const EdgeInsets.all(SpaceDims.sp4),
                child: Image.asset(widget.url),
              ),
              decoration: BoxDecoration(
                color: ColorSty.white60.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.nama,
                  style: TypoSty.title.copyWith(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.harga,
                  style: TypoSty.title.copyWith(color: ColorSty.primary),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.playlist_add_check,
                      color: ColorSty.primary,
                    ),
                    const SizedBox(width: SpaceDims.sp4),
                    Text(
                      "Tambahkan Catatan",
                      style: TypoSty.caption2.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0,
                        color: ColorSty.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (widget.amount != 0)
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (jumlahOrder != 0)
                      TextButton(
                        onPressed: () => setState(() => jumlahOrder--),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(25, 25),
                          side: const BorderSide(
                              color: ColorSty.primary, width: 2),
                        ),
                        child: const Icon(Icons.remove),
                      ),
                    if (jumlahOrder != 0)
                      Text("$jumlahOrder", style: TypoSty.subtitle),
                    TextButton(
                      onPressed: () => setState(() => jumlahOrder++),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(25, 25),
                        primary: ColorSty.white,
                        backgroundColor: ColorSty.primary,
                      ),
                      child: const Icon(Icons.add, color: ColorSty.white),
                    )
                  ],
                ),
              )
            else
              Expanded(
                child: Container(
                  alignment: Alignment.bottomRight,
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp12),
                  child:  Text("Stok Habis", style: TypoSty.caption.copyWith(color: ColorSty.grey)),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class LabelButton extends StatelessWidget {
  final String title;
  final IconData icon;

  const LabelButton({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp8),
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          primary: Icons.list == icon ? ColorSty.black : ColorSty.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        icon: Icon(icon),
        label: Text(title, style: TypoSty.subtitle),
      ),
    );
  }
}

class CardCoupon extends StatelessWidget {
  const CardCoupon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 158.0,
      width: 282.0,
      margin: const EdgeInsets.symmetric(horizontal: SpaceDims.sp12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Diskon",
                style: TypoSty.heading.copyWith(
                  color: ColorSty.white,
                ),
              ),
              const SizedBox(width: SpaceDims.sp12),
              Text(
                "10 %",
                style: TypoSty.heading.copyWith(
                  fontSize: 36.0,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 1
                    ..color = ColorSty.white,
                ),
              ),
            ],
          ),
          Text(
            "Lorem ipsum dolor sit amet",
            style: TypoSty.caption.copyWith(color: ColorSty.white),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: ColorSty.primary,
        borderRadius: BorderRadius.circular(7.0),
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            ColorSty.primary.withOpacity(0.1),
            BlendMode.dstATop,
          ),
          image: const AssetImage('assert/image/bg_coupon_card.png'),
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> datafake = [
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
  {
    "jenis": "makanan",
    "image": "assert/image/menu/167916789.png",
    "harga": "Rp 10.000",
    "nama": "Fried Rice",
    "amount": 0,
  },
];
