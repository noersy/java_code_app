import 'package:flutter/cupertino.dart';

class ProfileProviders extends ChangeNotifier {
  static bool _isKasir = false;

  bool get isKasir => _isKasir;

  changeRole() async {
    _isKasir = !_isKasir;
    notifyListeners();
  }
}
