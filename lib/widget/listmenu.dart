import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/widget/menuberanda_card.dart';

class ListMenu extends StatelessWidget {
  final String type, title;

  const ListMenu({
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
              type == "makanan"
                  ? SvgPicture.asset("assert/image/icons/ep_food.svg",
                      height: 22)
                  : SvgPicture.asset("assert/image/icons/ep_coffee.svg",
                      height: 26),
              const SizedBox(width: SpaceDims.sp4),
              Text(
                title,
                style: TypoSty.title.copyWith(color: ColorSty.primary),
              ),
            ],
          ),
        ),
        const SizedBox(height: SpaceDims.sp12),
        SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              if (type == "makanan")
                for (Map<String, dynamic> item in datafakeMakanan)
                  CardMenu(data: item),
              if (type == "minuman")
                for (Map<String, dynamic> item in datafakeMinuman)
                  CardMenu(data: item),
            ],
          ),
        ),
      ],
    );
  }
}

List<Map<String, dynamic>> datafakeMakanan = [
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

List<Map<String, dynamic>> datafakeMinuman = [
  {
    "jenis": "min",
    "image": "assert/image/menu/1637916759.png",
    "harga": "Rp 10.000",
    "name": "Es Jeruk",
    "amount": 99,
  },
];
