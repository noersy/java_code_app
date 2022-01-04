import 'package:flutter/cupertino.dart';

class OrderProvider extends ChangeNotifier {
  static int _order = 0;

  int get order => _order;

  addOrder(int jumlah) async {
    _order += jumlah;
    notifyListeners();
  }
}
