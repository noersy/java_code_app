import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:java_code_app/models/list_voucher.dart';
import 'package:java_code_app/models/listdiscount.dart';
import 'package:java_code_app/models/menudetail.dart';
import 'package:java_code_app/models/menulist.dart';
import 'package:java_code_app/tools/random_string.dart';
import 'package:java_code_app/widget/listmenu.dart';

class OrderProviders extends ChangeNotifier {
  // static int _orderInProgress = 0;
  // static int _checkOrder = 0;
  static const String _domain = "javacode.ngodingin.com";

  static Map<String, dynamic> _checkOrder = {};
  static List<Map<String, dynamic>> _orderInProgress = [];
  static MenuList? _menuList;
  static List<LVoucher> _listVoucher = [];
  static List<Discount> _listDiscount = [];

  MenuList? get listMenu => _menuList;
  Map<String, dynamic> get checkOrder => _checkOrder;
  List<Map<String, dynamic>> get orderProgress => _orderInProgress;
  List<LVoucher> get listVoucher => _listVoucher;
  List<Discount> listDiscount = _listDiscount;

  addOrder({
    required Map<String, dynamic> data,
    required int jumlahOrder,
    required String catatan,
    required String level,
    required List<String> topping,
  }) async {
    _checkOrder.addAll({
      data["id"]: {
        "id": data["id"],
        "jenis": data["jenis"],
        "image": data["image"],
        "harga": data["harga"],
        "amount": data["amount"],
        "name": data["name"],
        "level": level,
        "topping": topping,
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
    required Map<String, dynamic> data,
    required int jumlahOrder,
    required String catatan,
    required String level,
    required List<String> topping,
  }) async {
    _checkOrder.update(
      data["id"],
      (value) => {
        "id": value["id"],
        "jenis": value["jenis"],
        "image": value["image"],
        "harga": value["harga"],
        "amount": value["amount"],
        "name": value["name"],
        "level": level.isEmpty ? value["level"] : level,
        "topping": topping.isEmpty ? value["topping"] : topping,
        "catatan": catatan.isEmpty ? value["catatan"] : catatan,
        "countOrder": jumlahOrder,
      },
    );
    notifyListeners();
  }

  submitOrder(LVoucher? voucher) async {
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
      final _api = Uri.https(_domain, "/api/menu/all");
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
      final _api = Uri.https(_domain, "/api/menu/detail/$id");

      final headers = {"token": "m_app"};

      final response = await http.get(_api, headers: headers);

      if (response.statusCode == 200) {
        return menuDetailFromJson(response.body);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> getListVoucher() async {
    try {
      final _api = Uri.https(_domain, "/api/voucher/all");

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
      final _api = Uri.https(_domain, "/api/diskon/user/1");

      final headers = {"token": "m_app"};

      final response = await http.get(_api, headers: headers);

      print(response.body);

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
}
