import 'package:flutter/material.dart';
import 'package:java_code_app/thame/colors.dart';
import 'package:java_code_app/thame/spacing.dart';
import 'package:java_code_app/thame/text_style.dart';

class TileListDMenu extends StatelessWidget {
  final String title;
  final String? prefix;
  final Widget? prefixCostume;
  final IconData icon;
  final bool? prefixIcon;
  final TextStyle? textStylePrefix;
  final Function() onPressed;
  final bool? dense;

  const TileListDMenu({
    Key? key,
    required this.title,
    this.prefix,
    required this.icon,
    this.prefixIcon,
    required this.onPressed,
    this.textStylePrefix,
    this.dense,
    this.prefixCostume,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(thickness: 1.5),
        ListTile(
          onTap: prefixIcon ?? false ? onPressed : null,
          leading: Padding(
            padding: const EdgeInsets.only(top: SpaceDims.sp2),
            child: Icon(icon, color: ColorSty.primary, size: 22.0),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp8),
          horizontalTitleGap: 0,
          minVerticalPadding: 0,
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TypoSty.captionBold),
              Row(
                children: [
                  SizedBox(
                    width: prefixCostume != null ? 140 : 108,
                    child: prefixCostume ?? Text(
                      prefix ?? "",
                      style: prefixIcon ?? false
                          ? TypoSty.captionSemiBold.copyWith(fontWeight: FontWeight.normal).merge(textStylePrefix)
                            : dense ?? false
                            ? TypoSty.captionSemiBold.copyWith(fontWeight: FontWeight.normal).merge(textStylePrefix)
                          : TypoSty.title.copyWith(color: ColorSty.primary).merge(textStylePrefix),
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (prefixIcon ?? false)
                    Padding(
                      padding: EdgeInsets.only(
                        left: dense ?? false ? SpaceDims.sp4 : SpaceDims.sp8,
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: dense ?? false ? 18.0 : 22.0,
                        color: ColorSty.grey,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
