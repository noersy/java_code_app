import 'package:flutter/material.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

Widget imageError(BuildContext context, Object error, StackTrace? stackTrace) {
  return const Icon(Icons.image_not_supported, color: Colors.grey);
}

Widget imageOnLoad(BuildContext context, Object error, ImageChunkEvent? stackTrace) {
  return Skeleton();
}

