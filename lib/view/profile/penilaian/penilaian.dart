import 'dart:convert';
import 'dart:io';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:java_code_app/providers/lang_providers.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/view/profile/penilaian/post_penilaian.dart';
import 'package:java_code_app/widget/appbar/appbar.dart';
import 'package:java_code_app/widget/dialog/custom_dialog.dart';
import 'package:java_code_app/widget/show_loading.dart';

class Penilaian extends StatefulWidget {
  const Penilaian({Key? key}) : super(key: key);

  @override
  _PenilaianState createState() => _PenilaianState();
}

class _PenilaianState extends State<Penilaian> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: LangProviders(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: const CostumeAppBar(
              title: '',
              profileTitle: 'Penilaian',
              // profileTitle: lang.profile.title,
              back: true,
            ),
            body: Stack(
              children: [
                Image.asset("assert/image/bg_daftarpenilaian.png"),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: ColorSty.white80,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 3,
                                    blurRadius: 3,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: Text(
                                            'Berikan Penilaianmu',
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                          ),
                                          child: Column(
                                            children: [
                                              RatingBar.builder(
                                                itemSize: 30,
                                                initialRating: 3,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemPadding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 4.0,
                                                ),
                                                itemBuilder: (context, _) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  // ignore: avoid_print
                                                  setState(() {
                                                    score = rating;
                                                    if (rating == 1) {
                                                      ratingText =
                                                          'jelek sekali';
                                                    }
                                                    if (rating == 1.5) {
                                                      ratingText = 'jelek';
                                                    }
                                                    if (rating == 2) {
                                                      ratingText =
                                                          'biasa sekali';
                                                    }
                                                    if (rating == 2.5) {
                                                      ratingText = 'biasa';
                                                    }
                                                    if (rating == 3) {
                                                      ratingText = 'lumayan';
                                                    }
                                                    if (rating == 3.5) {
                                                      ratingText = 'cukup';
                                                    }
                                                    if (rating == 4) {
                                                      ratingText = 'cukup baik';
                                                    }
                                                    if (rating == 4.5) {
                                                      ratingText = 'baik';
                                                    }
                                                    if (rating == 5) {
                                                      ratingText =
                                                          'bagus sekali';
                                                    }
                                                  });
                                                  // print(rating);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  widgetTextRating(ratingText),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            widgetType(context),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  onPost() async {
    if (textReviewController.text.isEmpty) {
      showSimpleDialog(context, 'Review harus ditulis!');
    } else {
      showLoading(context);
      postPenilaian(
        context,
        score,
        selectedType,
        textReviewController.text,
        base64Image,
      ).then((value) async {
        await hideLoading(context);
        await hideLoading(context);
        if (value['success']) {
          return showSimpleDialog(
            context,
            value['message'] ?? 'Penilaian berhasil!',
            lableClose: 'Tutup',
            onClose: () async {
              textReviewController.clear();
              Navigator.pop(context);
            },
          );
        } else {
          return showSimpleDialog(
            context,
            value['message'],
            title: 'Gagal!',
            lableClose: 'Tutup',
            onClose: () async {
              textReviewController.clear();
            },
          );
        }
        // imageBytes = [];
        // base64Image = '';
        // print(
        //     'clearing imageBytes:${imageBytes.length} | base64Image:${base64Image}');
      });
    }
  }

  List listType = [
    'Harga',
    'Rasa',
    'Penyajian Makanan',
    'Pelayanan',
    'Fasilitas'
  ];
  TextEditingController textReviewController = TextEditingController();
  Container widgetType(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 3,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('Apa yang bisa ditingkatkan?'),
            ),
            Wrap(
              children: [
                for (var i in listType) widgetButtonType(i),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                thickness: 2,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('Tulis Review'),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                enabled: true,
                style: TextStyle(fontSize: 10.0.sp),
                maxLines: 5,
                controller: textReviewController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  hintText: '',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          onPost();
                        },
                        child: const Text('Kirim Penilaian'),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )))),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromRGBO(0, 154, 173, 1), width: 2),
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      _showPicker(context);
                    },
                    icon: const Icon(
                      Icons.add_photo_alternate,
                      size: 20.0,
                      color: Color.fromRGBO(0, 154, 173, 1),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }

  // ignore: avoid_init_to_null
  File? _image = null;

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              color: Colors.white,
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      tileColor: Colors.white,
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Galeri'),
                      onTap: () {
                        _imgGaleri();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Kamera'),
                    onTap: () {
                      _imgKamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  List<int> imageBytes = [];
  // ignore: prefer_typing_uninitialized_variables
  var base64Image;
  void submit() async {
    imageBytes = _image!.readAsBytesSync();
    base64Image = base64Encode(imageBytes);
  }

  _imgKamera() async {
    final picker = ImagePicker();
    final image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 20);
    setState(() {
      _image = File(image!.path);
    });
    submit();
  }

  _imgGaleri() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 600,
        maxWidth: 600);
    setState(() {
      _image = File(image!.path);
    });
    submit();
  }

  var selectedType = 'Fasilitas';
  Widget widgetButtonType(i) {
    if (i == selectedType) {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(
                          color: Color.fromRGBO(0, 154, 173, 1))))),
          onPressed: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$i'),
              const SizedBox(
                width: 5,
              ),
              const Icon(Icons.check_circle)
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(
                          color: Color.fromRGBO(170, 170, 170, 1))))),
          onPressed: () {
            setState(() {
              selectedType = i;
            });
          },
          child: Text(
            '$i',
            style: const TextStyle(color: Color.fromRGBO(170, 170, 170, 1)),
          ),
        ),
      );
    }
  }

  String ratingText = 'rating now';
  double score = 1.0;
  Widget widgetTextRating(text) {
    // return Container(
    //     child: Row(
    //   children: <Widget>[
    //     Flexible(child: Text("A looooooooooooooooooong text"))
    //   ],
    // ));
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Text('$text'),
    );
  }

  String directoryYellow = 'assert/image/icons/star_yellow.png';
  String directoryGray = 'assert/image/icons/star_yellow.png';
}
