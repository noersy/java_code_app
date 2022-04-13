import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:java_code_app/models/menulist.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/view/branda/widget/menuberanda_card.dart';

class ListMenu extends StatefulWidget {
  final String type, title;
  final MenuList data;

  const ListMenu({
    Key? key,
    required this.type,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  State<ListMenu> createState() => _ListMenuState();
}

class _ListMenuState extends State<ListMenu> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: SpaceDims.sp22),
            Padding(
              padding: const EdgeInsets.only(left: SpaceDims.sp24),
              child: Row(
                children: [
                  widget.type == "makanan" || widget.type == 'snack'
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
                    widget.title,
                    style: TypoSty.title.copyWith(color: ColorSty.primary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: SpaceDims.sp12),
            SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                primary: false,
                child: Column(
                  children: widget.data.data.map((e) {
                    bool isAny = widget.data.data.any(
                      (el) => el.kategori == widget.type,
                    );
                    return isAny ? CardMenu(data: e) : const SizedBox();
                  }).toList(),
                  // [
                  //   for (final item in widget.data.data)
                  //     if (widget.type == item.kategori)
                  //         CardMenu(data: item),
                  // ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
