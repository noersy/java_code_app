import 'package:flutter/cupertino.dart';

class OrderProvider extends ChangeNotifier {
  // static int _orderInProgress = 0;
  // static int _checkOrder = 0;
  static List<Map<String, dynamic>> _orderInProgress = [];
  static List<Map<String, dynamic>> _checkOrder = [];

  List<Map<String, dynamic>> get checkOrder => _checkOrder;
  List<Map<String, dynamic>> get orderProgress => _orderInProgress;

  addOrder(Map<String, dynamic> item) async {
    _checkOrder.add(item);
    notifyListeners();
  }

  submitOrder() async {
    _orderInProgress = _checkOrder;
    _checkOrder.clear();
    notifyListeners();
  }
}
