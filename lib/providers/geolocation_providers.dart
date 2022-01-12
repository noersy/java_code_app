import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationProvider extends ChangeNotifier {
  Position? _position;

  getCurrentPosition() async {

    try {



      print(_position);
      notifyListeners();
      return;
    } on TimeoutException {
      print("Lokasi tidak ditemukan.");
    } catch (e) {}
    print("Lokasi tidak ditemukan.");
  }
}
