import 'package:flutter/material.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/widget/dialog/custom_text.dart';

showCustomSnackbar(
  BuildContext context,
  String? text, {
  Color? backColor,
  Color? textColor,
}) {
  var snackBar = SnackBar(
    backgroundColor: backColor ?? ColorSty.primaryDark,
    content: CustomText(
      text: 'Item belum ditambahkan!',
      color: textColor ?? Colors.white,
      isBold: true,
      fontSize: 18,
    ),
    duration: const Duration(milliseconds: 700),
  );
  ScaffoldMessenger.of(context).showSnackBar(
    snackBar,
  );
}
