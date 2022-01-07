import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/thame/colors.dart';
import 'package:java_code_app/thame/icons_cs_icons.dart';
import 'package:java_code_app/thame/spacing.dart';
import 'package:java_code_app/thame/text_style.dart';
import 'package:java_code_app/view/beranda_page.dart';
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
              type.compareTo("makanan") == 0
                  ? SvgPicture.asset("assert/image/icons/ep_food.svg", height: 22)
                  : SvgPicture.asset("assert/image/icons/ep_coffee.svg", height: 26),
              const SizedBox(width: SpaceDims.sp4),
              Text(title,
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
                if (item["jenis"]?.compareTo(type) == 0)
                  CardMenu(data: item),
            ],
          ),
        ),
      ],
    );
  }
}
