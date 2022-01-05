import 'package:flutter/painting.dart';
import 'package:java_code_app/thame/colors.dart';

class ShadowsB {
  static List<BoxShadow> boxShadow1 = [
    BoxShadow(
      offset: const Offset(0, -0.9),
      color: ColorSty.grey80.withOpacity(0.05),
      spreadRadius: 10,
    ),
    BoxShadow(
      offset: const Offset(0, -0.9),
      color: ColorSty.grey80.withOpacity(0.05),
      spreadRadius: 8,
    ),
    BoxShadow(
      offset: const Offset(0, -0.9),
      color: ColorSty.grey80.withOpacity(0.1),
      spreadRadius: 7,
    ),
    BoxShadow(
      offset: const Offset(0, -0.9),
      color: ColorSty.grey80.withOpacity(0.1),
      spreadRadius: 3,
    ),
    BoxShadow(
      offset: const Offset(0, -0.9),
      color: ColorSty.grey80.withOpacity(0.1),
      spreadRadius: 2,
    ),
  ];

  static List<BoxShadow> boxShadow2 = [
    for (int index in Iterable.generate(2))
      BoxShadow(
        color: ColorSty.grey80.withOpacity(0.1),
        spreadRadius: index.toDouble(),
        offset: const Offset(0, 1),
      ),
    for (int index in Iterable.generate(2))
      BoxShadow(
        color: ColorSty.grey80.withOpacity(0.1),
        spreadRadius: index.toDouble(),
        offset: const Offset(0, 1),
      ),
    for (int index in Iterable.generate(2))
      BoxShadow(
          color: ColorSty.grey80.withOpacity(0.1),
          spreadRadius: index.toDouble(),
          offset: const Offset(0, 1)),
    for (int index in Iterable.generate(3))
      BoxShadow(
        color: ColorSty.grey80.withOpacity(0.1),
        spreadRadius: index.toDouble(),
        offset: const Offset(0, 1),
      ),
    for (int index in Iterable.generate(4))
      BoxShadow(
        color: ColorSty.grey80.withOpacity(0.05),
        spreadRadius: index.toDouble(),
        offset: const Offset(0, 1),
      ),
    BoxShadow(
      color: ColorSty.grey80.withOpacity(0.05),
      spreadRadius: 4,
      offset: const Offset(0, 1),
    ),
    BoxShadow(
      color: ColorSty.grey80.withOpacity(0.05),
      spreadRadius: 3,
      offset: const Offset(0, 1),
    ),
    BoxShadow(
      color: ColorSty.grey80.withOpacity(0.05),
      spreadRadius: 2,
      offset: const Offset(0, 1),
    ),
  ];
}
