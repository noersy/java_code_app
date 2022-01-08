import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';

class LabelButton extends StatelessWidget {
  final String title;
  final IconData? icon;
  final SvgPicture? svgPicture;
  final Color? color;
  final Function() onPressed;

  const LabelButton({
    Key? key,
    required this.title,
    this.icon,
    required this.onPressed,
    this.color,
    this.svgPicture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp8),
      child: icon != null
          ? ElevatedButton.icon(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                primary: color ??
                    (Icons.list == icon ? ColorSty.black : ColorSty.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              icon: Icon(icon),
              label: Text(title, style: TypoSty.subtitle),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                primary: color ??
                    (Icons.list == icon ? ColorSty.black : ColorSty.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Row(
                children: [
                  svgPicture!,
                  const SizedBox(width: SpaceDims.sp8),
                  Text(title, style: TypoSty.subtitle),
                ],
              ),
            ),
    );
  }
}
