import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationProvider extends ChangeNotifier {
  Position? _position;

  getCurrentPosition() async {

    try {
      LocationPermission permission = await Geolocator.requestPermission();

      if (permission != LocationPermission.denied || permission != LocationPermission.deniedForever) {
        _position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      }

      print(_position);
      notifyListeners();
      return;
    } on TimeoutException {
      print("Lokasi tidak ditemukan.");
    } catch (e) {}
    print("Lokasi tidak ditemukan.");
  }
}
