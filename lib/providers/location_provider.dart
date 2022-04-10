import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider extends ChangeNotifier {
  late bool _serviceEnabled;
  late LocationPermission _permission;
  late Position _currentLoctaion;
  var _currentAddress;
  get serviceEnabled => _serviceEnabled;
  get permission => _permission;
  get currentLoctaion => _currentLoctaion;
  get currentAddress => _currentAddress;
  Future<Position> determinePosition() async {
    _permission = await Geolocator.checkPermission();
    // _serviceEnabled = await Geolocator.isLocationServiceEnabled();

    // if (!_serviceEnabled && (_permission == LocationPermission.deniedForever)) {
    //   await Geolocator.openLocationSettings();
    // }

    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
      if (_permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (_permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition().then(
      (value) {
        _currentLoctaion = value;
        notifyListeners();
        return _currentLoctaion;
      },
    );
  }

  getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentLoctaion.latitude, _currentLoctaion.longitude);
      Placemark place = placemarks[0];
      _currentAddress =
          "${place.street},${place.locality}, ${place.postalCode}, ${place.country}";
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
