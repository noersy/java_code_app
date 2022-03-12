import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:java_code_app/providers/lang_providers.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';

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

  void _navigationPage() async {
    Provider.of<LangProviders>(context, listen: false).checkLangPref();
    Navigate.toDashboard(context);
  }

  late bool serviceEnabled;
  late LocationPermission permission;

  Future<Position> _determinePosition() async {
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    return await Geolocator.getCurrentPosition().then(
      (value) {
        setState(() {
          _currentLoctaion = value;
        });
        return _currentLoctaion;
      },
    );
  }

  late Position _currentLoctaion;
  var _currentAddress;
  _getAddressFromLatLng() async {
    try {
      print(
          '_getAddressFromLatLng: $_currentLoctaion\n${_currentLoctaion.latitude} ${_currentLoctaion.longitude}');
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentLoctaion.latitude, _currentLoctaion.longitude);
      // List<Placemark> placemarks =
      //     await placemarkFromCoordinates(15.8343747, 74.5165815);
      print('placemarks: ${placemarks[0]}');
      Placemark place = placemarks[0];
      print('place: $place');
      setState(() {
        _currentAddress =
            "${place.street},${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _determinePosition()
        .then((value) => _getAddressFromLatLng())
        .then((value) => _navigationPage());
    // _startTime();
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
                        if (_currentAddress != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: SpaceDims.sp16,
                            ),
                            child: Text(
                              "$_currentAddress",
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
