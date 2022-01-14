import 'dart:io';
import 'dart:typed_data';

import 'package:cropperx/cropperx.dart';
import 'package:flutter/material.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/widget/appbar.dart';
import 'package:photo_view/photo_view.dart';

class ViewImage extends StatelessWidget {
  final String? urlImage;
  final File? file;

  const ViewImage({Key? key, this.urlImage, this.file}) : super(key: key);

  static final _cropperKey = GlobalKey(debugLabel: "cropperKey");

  void _save(BuildContext context) async{
    Uint8List? imageBytes = await Cropper.crop(
      cropperKey: _cropperKey,
    );

    // final test = File.fromRawPath(imageBytes!);
    // print(Image.memory(imageBytes!).height);

    if(imageBytes != null) {
      // Navigator.pop(context, test);
    }
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider? _imageProvider;

    if (urlImage != null) _imageProvider = AssetImage(urlImage!);
    if (file != null) _imageProvider = FileImage(file!);

    return Scaffold(
      backgroundColor: file != null
          ? const Color(0xff808080)
          : Colors.grey.withOpacity(0.2),
      appBar: file != null
          ? const CostumeAppBar(
              back: true,
              title: "Corp",
            )
          : null,
      body: file == null
          ? PhotoView(
              heroAttributes: const PhotoViewHeroAttributes(tag: "image"),
              imageProvider: _imageProvider,
              maxScale: 0.9,
              minScale: 0.1,
              initialScale: 0.5,
              backgroundDecoration: const BoxDecoration(
                color: Colors.transparent,
              ),
            )
          : Cropper(
              cropperKey: _cropperKey,
              overlayType: OverlayType.circle,
              zoomScale: 1,
              image: Image.file(file!),
            ),
      bottomNavigationBar: file != null
          ? Container(
              height: 65.0,
              decoration: const BoxDecoration(
                color: ColorSty.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: ColorSty.white,
                      onPrimary: ColorSty.primary,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: ColorSty.primary),
                        borderRadius: BorderRadius.circular(30.0),
                      )
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: SizedBox(
                      width: 120,
                        height: 36.0,
                        child: Align(
                          alignment: Alignment.center,
                            child: Text("Back", style: TypoSty.button),
                        ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )
                    ),
                    onPressed: () =>_save(context),
                    child: SizedBox(
                      width: 120,
                        height: 36.0,
                        child: Align(
                          alignment: Alignment.center,
                            child: Text("Save", style: TypoSty.button),
                        ),
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
