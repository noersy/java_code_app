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
    // Test if location services are enabled.
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      await Geolocator.openLocationSettings();
      // return Future.error('Location services are disabled.');
    }

    _permission = await Geolocator.checkPermission();
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
    } catch (e) {
      print(e);
    }
  }
}
