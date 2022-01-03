
import 'package:flutter/material.dart';
import 'package:java_code_app/thame/colors.dart';
import 'package:java_code_app/thame/spacing.dart';
import 'package:java_code_app/thame/text_style.dart';

class ButtonLogin extends StatelessWidget {
  final String? icon;
  final Color bgColors;
  final String title;
  final Function() onPressed;

  const ButtonLogin({
    Key? key,
    this.icon,
    this.boldTitle,
    required this.bgColors,
    required this.title, required this.onPressed,
  }) : super(key: key);

  final String? boldTitle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: bgColors,
        onPrimary: bgColors == ColorSty.white ? ColorSty.primary : ColorSty.white,
        padding: const EdgeInsets.symmetric(vertical: SpaceDims.sp16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(144.0),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: SpaceDims.sp12),
                child: Image.asset(icon!),
              ),
            Text(
              title,
              style: TypoSty.button.copyWith(
                fontWeight: boldTitle == null ? FontWeight.bold : null,
                color: ColorSty.white != bgColors
                    ? ColorSty.white
                    : ColorSty.black,
              ),
            ),
            if (boldTitle != null)
              Text(
                " " + boldTitle!,
                style: TypoSty.button.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ColorSty.white != bgColors
                      ? ColorSty.white
                      : ColorSty.black,
                ),
              ),
          ],
        ),
      ),
    );
  }
}