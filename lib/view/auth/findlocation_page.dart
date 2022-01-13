import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';

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
    final safeTopPadding = MediaQuery.of(context).padding.vertical;
    final height = MediaQuery.of(context).size.height;

    return ScreenUtilInit(builder: () {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              height: height <= 780 ? height + safeTopPadding + 20 : height,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 35.0.w,
                        vertical: 35.0.h,
                      ),
                      child: Image.asset('assert/image/bg_findlocation.png'),
                    ),
                  ),
                  SizedBox(
                    height: 460.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Mencari Lokasimu ...",
                          textAlign: TextAlign.center,
                          style: TypoSty.title2,
                        ),
                        const SizedBox(height: SpaceDims.sp2),
                        Image.asset("assert/image/maps_ilustrasion.png"),
                        const SizedBox(height: SpaceDims.sp24),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: SpaceDims.sp16,
                          ),
                          child: Text(
                            "Perumahan\nGriyashanta Permata\nN-524, Mojolangu,\nKec. Lowokwaru,\nKota Malang",
                            textAlign: TextAlign.center,
                            style: TypoSty.title.copyWith(fontSize: 20.0),
                          ),
                        ),
                        const SizedBox(height: SpaceDims.sp24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
