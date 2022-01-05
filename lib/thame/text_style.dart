import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code_app/thame/colors.dart';

class TypoSty {
  static const TextStyle heading = TextStyle(
    fontFamily: "Montserrat",
    fontWeight: FontWeight.w700,
    fontSize: 36.0,
  );

  static TextStyle title = TextStyle(
    fontFamily: "Montserrat",
    fontWeight: FontWeight.bold,
    color: ColorSty.black,
    fontSize: ScreenUtil().setSp(16),
  );

  static const TextStyle titlePrimary = TextStyle(
    fontFamily: "Montserrat",
    fontWeight: FontWeight.bold,
    color: ColorSty.primary,
    fontSize: 20.0,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: "Montserrat",
    fontWeight: FontWeight.bold,
    fontSize: 16.0,
  );

  static const TextStyle subtitle2 = TextStyle(
    fontFamily: "Montserrat",
    fontWeight: FontWeight.w600,
    fontSize: 16.0,
  );

  static const TextStyle title2 = TextStyle(
    fontFamily: "Montserrat",
    fontWeight: FontWeight.normal,
    fontSize: 20.0,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: "Montserrat",
    fontWeight: FontWeight.normal,
    fontSize: 16.0,
  );

  static const TextStyle captionSemiBold = TextStyle(
    fontFamily: "Montserrat",
    fontWeight: FontWeight.w600,
    fontSize: 16.0,
  );

  static const TextStyle captionBold = TextStyle(
    fontFamily: "Montserrat",
    fontWeight: FontWeight.bold,
    fontSize: 16.0,
  );

  static const TextStyle caption2 = TextStyle(
    fontFamily: "Montserrat",
    fontWeight: FontWeight.bold,
    color: Colors.grey,
    fontSize: 14.0,
  );

  static const TextStyle button = TextStyle(
    fontFamily: "Montserrat",
    fontWeight: FontWeight.w600,
    fontSize: 14.0,
  );

  static const TextStyle mini = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 11.0,
  );
}
