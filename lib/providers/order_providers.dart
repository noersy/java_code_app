// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:java_code_app/constans/hosts.dart';
import 'package:java_code_app/models/listdiscount.dart';
import 'package:java_code_app/models/listhistory.dart';
import 'package:java_code_app/models/listorder.dart';
import 'package:java_code_app/models/listpromo.dart';
import 'package:java_code_app/models/listvoucher.dart';
import 'package:java_code_app/models/menudetail.dart';
import 'package:java_code_app/models/menulist.dart';
import 'package:java_code_app/models/orderdetail.dart' as detail;
import 'package:java_code_app/singletons/random_string.dart';
import 'package:java_code_app/singletons/user_instance.dart';
import 'package:logging/logging.dart' as logging;

class TotalHistory {
  var totalHistory;
  TotalHistory({this.totalHistory});
  factory TotalHistory.fromJson(Map<String, dynamic> json) {
    return TotalHistory(totalHistory: json['total_order']);
  }
}

class OrderProviders extends ChangeNotifier {
  static final _log = logging.Logger('OrderProvider');
  static const headers = {"Content-Type": "application/json", "token": "m_app"};
  // static int _orderInProgress = 0;
  // static int _checkOrder = 0;

  static Map<String, dynamic> _checkOrder = {};
  static List<Map<String, dynamic>> _orderInProgress = [];
  static MenuList? _menuList;
  static List<LVoucher> _listVoucher = [];
  static List<Discount> _listDiscount = [];
  static List<Promo> _listPromo = [];
  static List<Order> _orders = [];
  static LVoucher? _selectedVoucher;

  MenuList? get listMenu => _menuList;
  Map<String, dynamic> get checkOrder => _checkOrder;
  List<Map<String, dynamic>> get orderProgress => _orderInProgress;
  List<LVoucher> get listVoucher => _listVoucher;
  List<Discount> get listDiscount => _listDiscount;
  List<Promo> get listPromo => _listPromo;
  List<Order> get listOrders => _orders;
  LVoucher? get selectedVoucher => _selectedVoucher;

  clear() {
    _checkOrder = {};
    _orderInProgress = [];
    _menuList = null;
    _listVoucher = [];
    _listDiscount = [];
    _listPromo = [];
    _orders = [];
    _selectedVoucher = null;

    _log.fine("clear all orders");
    notifyListeners();
  }

  addOrder({
    required Map<String, dynamic> data,
    required int jumlahOrder,
    required String catatan,
    Level? level,
    List<Level>? topping,
  }) async {
    final item = {
      "${data["id"]}": {
        "id": data["id"],
        "jenis": data["jenis"],
        "image": data["image"],
        "harga": data["harga"],
        "amount": data["amount"],
        "name": data["name"],
        "level": "${level?.idDetail}",
        "topping": topping?.map((e) => e.idDetail).toList(),
        "catatan": catatan,
        "countOrder": jumlahOrder,
      }
    };
    _checkOrder.addAll(item);
    _log.fine("add order: ${data["name"]}");
    notifyListeners();
  }

  deleteOrder({required String id}) async {
    final data = _checkOrder.remove(id);
    _log.fine("delete: ${data["name"]}");
    notifyListeners();
  }

  editOrder({
    required String id,
    required int jumlahOrder,
    required String catatan,
    num? hargaTotal,
    Level? level,
    List<Level>? topping,
  }) async {
    final data = _checkOrder.update(
      id,
      (value) => {
        "id": value["id"],
        "jenis": value["jenis"],
        "image": value["image"],
        "harga": hargaTotal ?? value["harga"],
        "amount": value["amount"],
        "name": value["name"],
        "level": level == null ? value["topping"] : "${level.idDetail}",
        "topping": topping == null
            ? value["topping"]
            : topping.map((e) => e.idDetail).toList(),
        "catatan": catatan.isEmpty ? value["catatan"] : catatan,
        "countOrder": jumlahOrder,
      },
    );

    _log.fine("Update order: ${data["name"]}");
    notifyListeners();
  }

  submitOrder({LVoucher? voucher}) async {
    final _id = RanString.getInstance().getRandomString(5);

    _orderInProgress.add({
      "id": _id,
      "orders": _checkOrder.values.toList(),
      "voucher": voucher ?? {},
    });

    _checkOrder = {};
    _log.fine("Submit order");
    notifyListeners();
  }

  Future<MenuList?> getMenuList() async {
    try {
      final _api = Uri.http(host, "$sub/api/menu/all");

      _log.fine("Tray get all menu.");
      final response = await http.get(_api, headers: headers);

      if (response.statusCode == 200 &&
          json.decode(response.body)["status_code"] == 200) {
        _menuList = menuListFromJson(response.body);
        if (_menuList != null) _log.fine("Success get all menu");
        notifyListeners();
        return _menuList;
      }

      _log.info("Fail to get all menu");
      _log.info(response.body);
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<MenuDetail?> getDetailMenu({required int id}) async {
    try {
      final _api = Uri.http(host, "$sub/api/menu/detail/$id");

      _log.fine("Try to get menu detail");
      final response = await http.get(_api, headers: headers);

      if (response.statusCode == 200 &&
          json.decode(response.body)["status_code"] == 200) {
        _log.fine("Success get detail menu");
        return menuDetailFromJson(response.body);
      }

      _log.info("Fail to get menu detail");
      _log.info(response.body);
      return null;
    } catch (e, r) {
      _log.warning(e);
      _log.warning(r);
      return null;
    }
  }

  Future<bool> getListVoucher() async {
    try {
      final user = UserInstance.getInstance().user;
      if (user == null) return false;
      final _api = Uri.http(host, "$sub/api/voucher/user/${user.data.idUser}");

      _log.fine("Try to get list voucher.");
      final response = await http.get(_api, headers: headers);

      if (response.statusCode == 200 &&
          json.decode(response.body)["status_code"] == 200) {
        _listVoucher = listVoucherFromJson(response.body).data;
        _log.fine("Success get list voucher");
        notifyListeners();
        return true;
      }

      _log.info("Fail to get list voucher");
      _log.info(response.body);
      return false;
    } catch (e, r) {
      _log.warning(e);
      _log.warning(r);
      return false;
    }
  }

  Future<bool> getListDisCount() async {
    final user = UserInstance.getInstance().user;
    if (user == null) return false;

    try {
      final _api = Uri.http(host, "$sub/api/diskon/user/${user.data.idUser}");

      _log.fine("Try to get list discount");
      final response = await http.get(_api, headers: headers);

      if (response.statusCode == 200 &&
          json.decode(response.body)["status_code"] == 200) {
        _listDiscount = listDiscountFromJson(response.body).data;
        _log.fine("Success get list discount");
        notifyListeners();
        return true;
      }

      _log.info("Fail to get list discount");
      _log.info(response.body);
      return false;
    } catch (e, r) {
      _log.warning(e);
      _log.warning(r);
      return false;
    }
  }

  Future<bool> getListPromo() async {
    final user = UserInstance.getInstance().user;
    if (user == null) return false;

    try {
      final _api = Uri.http(host, "$sub/api/promo/user/${user.data.idUser}");

      _log.fine("Try to get list promo");
      final response = await http.get(_api, headers: headers);

      if (response.statusCode == 204) {
        _log.info("Promo is empty");
        _listPromo = [];
      }

      if (response.statusCode == 200 &&
          json.decode(response.body)["status_code"] == 200) {
        _listPromo = listPromoFromJson(response.body).data;
        _log.fine("Success get list promo");
        notifyListeners();
        return true;
      }

      _log.info("Fail to get get list promo");
      _log.info(response.body);
      return false;
    } catch (e, r) {
      _log.warning(e);
      _log.warning(r);
      return false;
    }
  }

  Future<bool> getListOrder() async {
    final user = UserInstance.getInstance().user;
    if (user == null) return false;
    try {
      final _api = Uri.http(host, "$sub/api/order/proses/${user.data.idUser}");

      _log.fine("Try to get order in progress");
      final response = await http.get(_api, headers: headers);

      if (response.statusCode == 204 ||
          json.decode(response.body)["status_code"] == 204) {
        _log.info("Order is empty");
        _orders = [];
      }

      if (response.statusCode == 200 &&
          json.decode(response.body)["status_code"] == 200) {
        _orders = listOrderFromJson(response.body).data;
        if (_orders.isEmpty) _log.info("Failed get order in progress.");
        _log.fine("Success get order in progress.");
        notifyListeners();
        return true;
      }
      _log.info("Fail to get order in progress");
      _log.info(response.body);
      return false;
    } catch (e, r) {
      _log.warning(e);
      _log.warning(r);
      return false;
    }
  }

  Future<detail.OrderDetail?> getDetailOrder({required int id}) async {
    try {
      final _api = Uri.http(host, "$sub/api/order/detail/$id");

      _log.fine("Tray to get detail order");
      final response = await http.get(_api, headers: headers);

      if (response.statusCode == 200 &&
          json.decode(response.body)["status_code"] == 200) {
        _log.fine("Success get detail order");
        return detail.orderDetailFromJson(response.body);
      }
      _log.info("Fail to get detail order");
      _log.info(response.body);
    } catch (e, r) {
      _log.warning(e);
      _log.warning(r);
    }
    return null;
  }

  Future getTotalHistory() async {
    final user = UserInstance.getInstance().user;

    if (user == null) return null;

    try {
      _log.fine("Try to get list history of order");
      final response = await http.get(
          Uri.parse("https://$host/api/order/history/total/1"),
          headers: headers);
      // final response = await http.get(
      //   _api,
      //   headers: headers,
      // );
      // print('response.limit: ${response.body}');
      if (response.statusCode == 204) {
        _log.info("History if empty");
        return [];
      }

      if (response.statusCode == 200 &&
          json.decode(response.body)["status_code"] == 200) {
        _log.fine("Success get list history of order:");
        return response.body;
        // return listHistoryFromJson(response.body).data;
      }
      _log.info("Fail to get liest history");
      _log.info(response.body);
    } catch (e, r) {
      _log.warning(e);
      _log.warning(r);
    }
    return null;
  }

  Future<List<History>?> getHistoryLimit(limit, start) async {
    final user = UserInstance.getInstance().user;
    // print('user: ${user!.data.idUser}');

    if (user == null) return null;

    try {
      _log.fine("Try to get list history of order");
      final response = await http.get(
          Uri.parse(
              "https://$host/api/order/history/${user.data.idUser}?limit=$limit&start=$start"),
          headers: headers);
      // final response = await http.get(
      //   _api,
      //   headers: headers,
      // );
      // print('response.limit: ${response.body}');
      if (response.statusCode == 204) {
        _log.info("History if empty");
        return [];
      }

      if (response.statusCode == 200 &&
          json.decode(response.body)["status_code"] == 200) {
        _log.fine("Success get list history of order:");
        // print('body sukses:\n${response.body}');
        return listHistoryFromJson(response.body).data;
      }
      _log.info("Fail to get liest history");
      _log.info(response.body);
    } catch (e, r) {
      _log.warning(e);
      _log.warning(r);
    }
    return null;
  }

  Future<List<History>?> getHistoryList() async {
    final user = UserInstance.getInstance().user;

    if (user == null) return null;

    try {
      final _api = Uri.http(host, "$sub/api/order/history/${user.data.idUser}");

      _log.fine("Try to get list history of order");
      final response = await http.get(_api, headers: headers);

      if (response.statusCode == 204) {
        _log.info("History if empty");
        return [];
      }

      if (response.statusCode == 200 &&
          json.decode(response.body)["status_code"] == 200) {
        _log.fine("Success get list history of order");
        return listHistoryFromJson(response.body).data;
      }
      _log.info("Fail to get liest history");
      _log.info(response.body);
    } catch (e, r) {
      _log.warning(e);
      _log.warning(r);
    }
    return null;
  }

  Future<bool> cancelOrder({required int idOrder}) async {
    try {
      final _api = Uri.http(host, "$sub/api/order/batal/$idOrder");

      _log.fine("Tray to cancel a order");
      final response = await http.post(_api, headers: headers);

      if (response.statusCode == 200 &&
          json.decode(response.body)["status_code"] == 200) {
        _log.fine("Success cancel a order");
        return true;
      }
      _log.info("Failed to cancel a order");
      _log.info(response.body);
    } catch (e, r) {
      _log.warning(e);
      _log.warning(r);
    }
    return false;
  }

  Future<bool> sendCheckOut({
    int? idVoucher,
    List<int>? idDiscount,
    int? discount,
    int? totalPotong,
    required int totalOrder,
    required int totalPay,
    required List<Map<String, dynamic>> menu,
  }) async {
    try {
      final user = UserInstance.getInstance().user;
      if (user == null) return false;

      final _api = Uri.http(host, "$sub/api/order/add");

      final body = {
        "order": {
          "id_user": user.data.idUser,
          "id_voucher": idVoucher,
          "potongan": totalPotong,
          "id_diskon": idDiscount,
          "diskon": discount,
          "total_bayar": totalPay,
          "total_order": totalOrder
        },
        "menu": menu
      };

      _log.fine("Tray to checkout order");
      final response = await http.post(_api,
          headers: headers,
          body: jsonEncode(body),
          encoding: Encoding.getByName("utf-8"));
      // print('body print $body');
      if (response.statusCode == 200 &&
          json.decode(response.body)["status_code"] == 200) {
        submitOrder();
        getListOrder();

        _log.fine("Checkout success");
        notifyListeners();
        return true;
      }

      _log.warning("Checkout failed");
      _log.info(response.body);
      return false;
    } catch (e, r) {
      _log.warning(e);
      _log.warning(r);
      return false;
    }
  }

  setVoucher(LVoucher? data) {
    _selectedVoucher = data;
    notifyListeners();
  }

  setVoucherEmpty() {
    _selectedVoucher = null;
    notifyListeners();
  }
}
