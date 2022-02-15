import 'dart:ffi';
import 'dart:io';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:java_code_app/providers/lang_providers.dart';
import 'package:java_code_app/view/profile/penilaian/post_penilaian.dart';
import 'package:java_code_app/widget/appbar/appbar.dart';

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
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF6F6F6),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding:
                                            EdgeInsets.only(left: 10, top: 10),
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
                                              initialRating: 3,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
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
                                                    RatingText = 'jelek sekali';
                                                  }
                                                  if (rating == 1.5) {
                                                    RatingText = 'jelek';
                                                  }
                                                  if (rating == 2) {
                                                    RatingText = 'biasa sekali';
                                                  }
                                                  if (rating == 2.5) {
                                                    RatingText = 'biasa';
                                                  }
                                                  if (rating == 3) {
                                                    RatingText = 'lumayan';
                                                  }
                                                  if (rating == 3.5) {
                                                    RatingText = 'cukup';
                                                  }
                                                  if (rating == 4) {
                                                    RatingText = 'cukup baik';
                                                  }
                                                  if (rating == 4.5) {
                                                    RatingText = 'baik';
                                                  }
                                                  if (rating == 5) {
                                                    RatingText = 'bagus banget';
                                                  }
                                                });
                                                print(rating);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  widgetTextRating('$RatingText')
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
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

  List listType = [
    'Harga',
    'Rasa',
    'Penyajian Makanan',
    'Pelayanan',
    'Fasilitas'
  ];
  TextEditingController textReview = TextEditingController();
  Container widgetType(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('Apa yang bisa ditingkatkan?'),
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
            const Text('Tulis Review'),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                enabled: true,
                style: TextStyle(fontSize: 12),
                maxLines: 5,
                controller: textReview,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '',
                    fillColor: Colors.white,
                    filled: true),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      postPenilaian(score, selectedType, '${textReview.text}');
                    },
                    child: const Text('Kirim Penilaian')),
                RawMaterialButton(
                  onPressed: () {
                    _showPicker(context);
                  },
                  elevation: 2.0,
                  fillColor: Colors.white,
                  child: const Icon(
                    Icons.pause,
                    size: 12.0,
                  ),
                  padding: const EdgeInsets.all(15.0),
                  shape: const CircleBorder(),
                )
              ],
            )
            // TextFormField(
            //   style: TextStyle(fontSize: 12),
            //   maxLines: 5,
            //   initialValue:
            //       'Mohon Menjaga Kebersihan, Kemarin Meja Masih Kotor',
            //   decoration: InputDecoration(
            //       border: OutlineInputBorder(),
            //       hintText: '',
            //       fillColor: Colors.white),
            // )
          ],
        ));
  }

  File? _image = null;

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              color: Colors.white,
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      tileColor: Colors.white,
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Galeri'),
                      onTap: () {}),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Kamera'),
                    onTap: () {
                      _imgKamera();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgKamera() async {
    final picker = ImagePicker();
    final image =
        await picker.getImage(source: ImageSource.camera, imageQuality: 20);
    setState(() {
      _image = File(image!.path);
    });
  }

  var selectedType = 'Fasilitas';
  Widget widgetButtonType(i) {
    if (i == selectedType) {
      return TextButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Color.fromRGBO(0, 154, 173, 1))))),
        onPressed: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${i}'),
            SizedBox(
              width: 5,
            ),
            Icon(Icons.check_circle)
          ],
        ),
      );
    } else {
      return TextButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side:
                        BorderSide(color: Color.fromRGBO(170, 170, 170, 1))))),
        onPressed: () {
          setState(() {
            selectedType = i;
          });
        },
        child: Text(
          '${i}',
          style: TextStyle(color: Color.fromRGBO(170, 170, 170, 1)),
        ),
      );
    }
  }

  String RatingText = 'rating now';
  double score = 1.0;
  Widget widgetTextRating(text) {
    return Padding(
      padding: EdgeInsets.only(right: 10.0),
      child: Text('$text'),
    );
  }

  String directoryYellow = 'assert/image/icons/star_yellow.png';
  String directoryGray = 'assert/image/icons/star_yellow.png';
}
