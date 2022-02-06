import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ViewImage extends StatelessWidget {
  final String urlImage;

  const ViewImage({Key? key, required this.urlImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.2),
        body: PhotoView(
          heroAttributes: const PhotoViewHeroAttributes(tag: "image"),
          imageProvider: NetworkImage(urlImage),
          maxScale: 0.9,
          minScale: 0.1,
          initialScale: 0.5,
          backgroundDecoration: const BoxDecoration(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
