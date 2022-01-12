import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationProvider extends ChangeNotifier {
  Position? _position;

  getCurrentPosition() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission != LocationPermission.denied) {
        _position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
      }
      print(_position.toString());
      notifyListeners();
    } on TimeoutException {
      print("Lokasi tidak ditemukan.");
    } catch (e) {}
  }
}
