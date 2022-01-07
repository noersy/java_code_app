import 'package:flutter/material.dart';
import 'package:java_code_app/thame/colors.dart';
import 'package:java_code_app/thame/icons_cs_icons.dart';
import 'package:java_code_app/thame/spacing.dart';
import 'package:java_code_app/thame/text_style.dart';
import 'package:java_code_app/widget/card_coupun.dart';
import 'package:java_code_app/widget/label_button.dart';
import 'package:java_code_app/widget/listmenu.dart';
import 'package:java_code_app/widget/silver_appbar.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({Key? key}) : super(key: key);

  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MainSilverAppBar(
        title: SizedBox(
          height: 42.0,
          child: TextFormField(
            decoration: InputDecoration(
              isDense: true,
              hintText: "Pencarian",
              prefixIcon: const Icon(IconsCs.search_icon, color: ColorSty.primary),
              contentPadding: const EdgeInsets.only(
                left: 53,
                right: SpaceDims.sp12,
                top: SpaceDims.sp12,
                bottom: SpaceDims.sp8,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: ColorSty.primary,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: ColorSty.primary,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: ColorSty.primary,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        ),
        floating: true,
        pinned: true,
        body: const ContentBeranda(),
      ),
    );
  }
}

class ContentBeranda extends StatefulWidget {
  const ContentBeranda({Key? key}) : super(key: key);

  @override
  State<ContentBeranda> createState() => _ContentBerandaState();
}

class _ContentBerandaState extends State<ContentBeranda> {
  int _selectedIndex = 0;
  final ScrollController _controller = ScrollController();

  final List<Widget> _category = [
    const SizedBox(),
    const ListMenu(type: "makanan", title: "Makanan"),
    const ListMenu(type: "minuman", title: "Minuman"),
  ];

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
                Text(
                  "Promo yang Tersedia",
                  style: TypoSty.title.copyWith(color: ColorSty.primary),
                ),
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
            controller: _controller,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: SpaceDims.sp12),
                LabelButton(
                  color: _selectedIndex == 0 ? ColorSty.black : ColorSty.primary,
                  onPressed: () => setState(() => _selectedIndex = 0),
                  title: "Semua Menu",
                  icon: Icons.list,
                ),
                LabelButton(
                  color: _selectedIndex == 1 ? ColorSty.black : ColorSty.primary,
                  onPressed: () => setState(() => _selectedIndex = 1),
                  title: "Makanan",
                  icon: Icons.coffee,
                ),
                LabelButton(
                  color: _selectedIndex == 2 ? ColorSty.black : ColorSty.primary,
                  onPressed: () => setState(() => _selectedIndex = 2),
                  title: "Minuman",
                  icon: IconsCs.ep_coffee,
                ),
              ],
            ),
          ),
          if (_selectedIndex == 0)
            for (Widget item in _category) item,
          if (_selectedIndex > 0) _category[_selectedIndex],
          const SizedBox(height: SpaceDims.sp12),
        ],
      ),
    );
  }
}

List<Map<String, dynamic>> datafake = [
  {
    "jenis": "minuman",
    "image": "assert/image/menu/1637916759.png",
    "harga": "Rp 10.000",
    "name": "Chicken Katsu",
    "amount": 99,
  },
  {
    "jenis": "makanan",
    "image": "assert/image/menu/1637916792.png",
    "harga": "Rp 10.000",
    "name": "Chicken Katsu",
    "amount": 99,
  },
  {
    "jenis": "makanan",
    "image": "assert/image/menu/1637916829.png",
    "harga": "Rp 10.000",
    "name": "Chicken Slam",
    "amount": 99,
  },
  {
    "jenis": "makanan",
    "image": "assert/image/menu/167916789.png",
    "harga": "Rp 10.000",
    "name": "Fried Rice",
    "amount": 0,
  },
];
