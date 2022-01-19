import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:java_code_app/constans/hosts.dart';
import 'package:java_code_app/models/listdiscount.dart';
import 'package:java_code_app/models/listorder.dart';
import 'package:java_code_app/models/listpromo.dart';
import 'package:java_code_app/models/listvoucher.dart';
import 'package:java_code_app/models/menudetail.dart';
import 'package:java_code_app/models/menulist.dart';
import 'package:java_code_app/singletons/random_string.dart';
import 'package:java_code_app/singletons/user_instance.dart';

class OrderProviders extends ChangeNotifier {
  // static int _orderInProgress = 0;
  // static int _checkOrder = 0;

  static Map<String, dynamic> _checkOrder = {};
  static List<Map<String, dynamic>> _orderInProgress = [];
  static MenuList? _menuList;
  static List<LVoucher> _listVoucher = [];
  static List<Discount> _listDiscount = [];
  static List<Promo> _listPromo = [];
  static List<Order> _listOrders = [];

  MenuList? get listMenu => _menuList;
  Map<String, dynamic> get checkOrder => _checkOrder;
  List<Map<String, dynamic>> get orderProgress => _orderInProgress;
  List<LVoucher> get listVoucher => _listVoucher;
  List<Discount> get listDiscount => _listDiscount;
  List<Promo> get listPromo => _listPromo;
  List<Order> get listOrders => _listOrders;

  // static final _connectionStatus = ConnectionStatus.getInstance();

  addOrder({
    required Map<String, dynamic> data,
    required int jumlahOrder,
    required String catatan,
    Level? level,
    List<Level>? topping,
  }) async {
    _checkOrder.addAll({
      "${data["id"]}": {
        "id": data["id"],
        "jenis": data["jenis"],
        "image": data["image"],
        "harga": data["harga"],
        "amount": data["amount"],
        "name": data["name"],
        "level": level?.idDetail,
        "topping": topping?.map((e) => e.idDetail).toList(),
        "catatan": catatan,
        "countOrder": jumlahOrder,
      }
    });
    notifyListeners();
  }

  deleteOrder({required String id}) async {
    _checkOrder.remove(id);
    notifyListeners();
  }

  editOrder({
    required String id,
    required int jumlahOrder,
    required String catatan,
    Level? level,
    List<Level>? topping,
  }) async {
    _checkOrder.update(
      id,
      (value) => {
        "id": value["id"],
        "jenis": value["jenis"],
        "image": value["image"],
        "harga": value["harga"],
        "amount": value["amount"],
        "name": value["name"],
        "level": level == null ? value["topping"] : level.idDetail,
        "topping": topping == null ? value["topping"] : topping.map((e) => e.idDetail).toList(),
        "catatan": catatan.isEmpty ? value["catatan"] : catatan,
        "countOrder": jumlahOrder,
      },
    );
    notifyListeners();
  }

  submitOrder({LVoucher? voucher}) async {
    final _id = RanString.getInstance().getRandomString(5);

    _orderInProgress.add({
      "id": _id,
      "orders": _checkOrder.values.toList(),
      "voucher": voucher ?? {},
    });

    // print(_orderInProgress);
    _checkOrder = {};
    notifyListeners();
  }

  Future<MenuList?> getMenuList() async {
    try {
      final _api = Uri.http(host, "$sub/api/menu/all");
      final headers = {"token": "m_app"};

      final response = await http.get(_api, headers: headers);

      // print(response.body);

      if (response.statusCode == 200) {
        _menuList = menuListFromJson(response.body);
        notifyListeners();
        return _menuList;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<MenuDetail?> getDetailMenu({required int id}) async {
    try {
      final _api = Uri.http(host, "$sub/api/menu/detail/$id");

      final headers = {"token": "m_app"};

      final response = await http.get(_api, headers: headers);

      print(response.body);

      if (response.statusCode == 200) {
        return menuDetailFromJson(response.body);
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> getListVoucher() async {
    try {
      final _api = Uri.http(host, "$sub/api/voucher/all");

      final headers = {"token": "m_app"};

      final response = await http.get(_api, headers: headers);

      if (response.statusCode == 200) {
        _listVoucher = listVoucherFromJson(response.body).data;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getListDisCount() async {
    try {
      final _api = Uri.http(host, "$sub/api/diskon/user/1");

      final headers = {"token": "m_app"};

      final response = await http.get(_api, headers: headers);

      // print(response.body);

      if (response.statusCode == 200) {
        _listDiscount = listDiscountFromJson(response.body).data;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getListPromo() async {
    try {
      final _api = Uri.http(host, "$sub/api/promo/all");

      final headers = {"token": "m_app"};

      final response = await http.get(_api, headers: headers);

      // print(response.body);

      if (response.statusCode == 200) {
        _listPromo = listPromoFromJson(response.body).data;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getListOrder() async {
    try {
      final _api = Uri.http(host, "$sub/api/promo/all");

      final headers = {"token": "m_app"};

      final response = await http.get(_api, headers: headers);

      // print(response.body);

      if (response.statusCode == 200) {
        _listOrders = listOrderFromJson(response.body).data;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> sendCheckOut({
    int? idVoucher,
    List<int>? idDiscount,
    int? discount,
    int? totalPotong,
    required int totalPay,
    required List<Map<String, dynamic>> menu,
  }) async {
    try {
      final user = UserInstance.getInstance().user;
      if(user == null) return false;

      final _api = Uri.http(host, "$sub/api/order/add");

      final headers = {
        "Content-Type" : "application/json",
        "token": "m_app"
      };

      final body = {
        "order": {
          "id_user": user.data.idUser,
          "id_voucher": idVoucher,
          "potongan": totalPotong,
          "id_diskon": idDiscount,
          "diskon": discount,
          "total_bayar": totalPay
        },
        "menu": menu
      };



      final response = await http.post(
          _api,
          headers: headers,
          body: jsonEncode(body),
          encoding: Encoding.getByName("utf-8")
      );
      if (response.statusCode == 200) {
        submitOrder();
        print(response.body);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e, r) {
      print(e);
      print(r);
      return false;
    }
  }
}
