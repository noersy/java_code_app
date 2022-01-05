import 'package:flutter/cupertino.dart';

class OrderProvider extends ChangeNotifier {
  static int _checkOrder = 0;
  static int _orderInProgress = 0;

  int get checkOrder => _checkOrder;
  int get orderProgress => _orderInProgress;

  addOrder(int jumlah) async {
    _checkOrder += jumlah;
    notifyListeners();
  }

  submitOrder() async {
    _orderInProgress = _checkOrder;
    _checkOrder = 0;
    notifyListeners();
  }
}
