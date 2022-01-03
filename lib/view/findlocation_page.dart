import 'dart:async';

import 'package:flutter/material.dart';
import 'package:java_code_app/thame/spacing.dart';
import 'package:java_code_app/thame/text_style.dart';
import 'package:java_code_app/route/route.dart';

class FindLocationPage extends StatefulWidget {
  const FindLocationPage({Key? key}) : super(key: key);

  @override
  State<FindLocationPage> createState() => _FindLocationPageState();
}

class _FindLocationPageState extends State<FindLocationPage> {

  _startTime() async {
    var _duration = const Duration(seconds: 3);
    return Timer(_duration, _navigationPage);
  }

  void _navigationPage() async => Navigate.toDashboard(context);

  @override
  void initState() {
    _startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: Image.asset('assert/image/bg_findlocation.png'),
            ),
            SizedBox(
              height: 380.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Mencari Lokasimu ...",
                    textAlign: TextAlign.center,
                    style: TypoSty.title2,
                  ),
                  Image.asset("assert/image/maps_ilustrasion.png"),
                  const SizedBox(height: SpaceDims.sp8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: SpaceDims.sp16),
                    child: Text(
                      "Perumahan Griyashanta Permata N-524, Mojolangu, Kec. Lowokwaru, Kota Malang",
                      textAlign: TextAlign.center,
                      style: TypoSty.title,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
