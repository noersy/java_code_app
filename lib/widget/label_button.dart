import 'package:flutter/material.dart';
import 'package:java_code_app/thame/colors.dart';
import 'package:java_code_app/thame/spacing.dart';
import 'package:java_code_app/thame/text_style.dart';

class LabelButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? color;
  final Function() onPressed;

  const LabelButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp8),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: color ?? (Icons.list == icon ? ColorSty.black : ColorSty.primary),
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
