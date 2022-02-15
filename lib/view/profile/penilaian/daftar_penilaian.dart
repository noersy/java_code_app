import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:java_code_app/models/listreview.dart';
import 'package:java_code_app/providers/lang_providers.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/widget/appbar/appbar.dart';
import 'fetch_rating.dart';

class DaftarPenilaian extends StatefulWidget {
  const DaftarPenilaian({Key? key}) : super(key: key);

  @override
  _DaftarPenilaianState createState() => _DaftarPenilaianState();
}

class _DaftarPenilaianState extends State<DaftarPenilaian>
    with TickerProviderStateMixin {
  loadReview() {
    print('loadReview: ');
    Future data = getAllReview();
    data.then((value) {
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        print('loadReview i: $i');
        Review rv = Review.fromJson(i);
        listReview.add(rv);
      }
      setState(() {
        widgetListReview();
      });
    });
    // Future data = Review;
    //     .then((value) {
    //   print('loadReview value:');
    //   Map json = jsonDecode(value);
    //   Review rview = Review.fromJson(json['data']);
    //   print('daftar review ');
    // })) ??
    // [];
  }

  @override
  void initState() {
    loadReview();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: LangProviders(),
        builder: (context, snapshot) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Container(
                width: 60,
                height: 60,
                child: const Icon(
                  Icons.add,
                  size: 40,
                ),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 64, 179, 174),
                      Color.fromARGB(255, 1, 154, 173),
                    ])),
              ),
              onPressed: () => Navigate.toPenilaian(context),
            ),
            appBar: const CostumeAppBar(
              title: '',
              profileTitle: 'Daftar Penilaian',
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
                        widgetListReview(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  ListView widgetListReview() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: listReview.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigate.toBalasanReview(context),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assert/image/icons/kalender.svg",
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${listReview[index].type}',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 1, 154, 173)),
                            ),
                            Image.asset('assert/image/icons/star_yellow.png'),
                            Image.asset('assert/image/icons/star_yellow.png'),
                            Image.asset('assert/image/icons/star_yellow.png'),
                            Image.asset('assert/image/icons/star_yellow.png'),
                            SvgPicture.asset(
                              "assert/image/icons/star_gray.svg",
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10, bottom: 10),
                        child: Text(
                          'keterangan  ',
                          textAlign: TextAlign.start,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }
}
