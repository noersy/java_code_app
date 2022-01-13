

import 'package:flutter/material.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:photo_view/photo_view.dart';

class ViewImage extends StatelessWidget {
  final String urlImage;
  const ViewImage({Key? key, required this.urlImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSty.grey.withOpacity(0.3),
      body: PhotoView(
        heroAttributes: const PhotoViewHeroAttributes(tag: "image"),
        imageProvider: AssetImage(urlImage),
        maxScale: 0.9,
        minScale: 0.5,
        initialScale: 0.5,
        backgroundDecoration: const BoxDecoration(
          color: Colors.transparent,
        ),
      ),
    );
  }
}
