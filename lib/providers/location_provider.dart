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
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
      if (_permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (_permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    return await Geolocator.getCurrentPosition().then(
      (value) {
        _currentLoctaion = value;
        return _currentLoctaion;
      },
    );
  }

  getAddressFromLatLng() async {
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

      _currentAddress =
          "${place.street},${place.locality}, ${place.postalCode}, ${place.country}";
    } catch (e) {
      print(e);
    }
  }
}
