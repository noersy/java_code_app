// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:java_code_app/constans/gettoken.dart';
import 'package:java_code_app/constans/hosts.dart';
import 'package:java_code_app/models/listdiscount.dart';
import 'package:java_code_app/models/listhistory.dart';
import 'package:java_code_app/models/listorder.dart';
import 'package:java_code_app/models/listpromo.dart';
import 'package:java_code_app/models/listvoucher.dart';
import 'package:java_code_app/models/menudetail.dart';
import 'package:java_code_app/models/menulist.dart';
import 'package:java_code_app/models/orderdetail.dart' as detail;
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/singletons/random_string.dart';
import 'package:java_code_app/singletons/user_instance.dart';
import 'package:java_code_app/widget/dialog/custom_dialog.dart';
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
  static bool? _isVoucherUsed = false;
  static bool? _isNetworkError = false;

  MenuList? get listMenu => _menuList;
  Map<String, dynamic> get checkOrder => _checkOrder;
  List<Map<String, dynamic>> get orderProgress => _orderInProgress;
  List<LVoucher> get listVoucher => _listVoucher;
  List<Discount> get listDiscount => _listDiscount;
  List<Promo> get listPromo => _listPromo;
  List<Order> get listOrders => _orders;
  LVoucher? get selectedVoucher => _selectedVoucher;
  bool? get isVoucherUsed => _isVoucherUsed;
  bool? get isNetworkError => _isNetworkError;

  clear() {
    _checkOrder = {};
    _orderInProgress = [];
    _menuList = null;
    _listVoucher = [];
    _listDiscount = [];
    _listPromo = [];
    _orders = [];

    _log.fine("clear all orders");
    notifyListeners();
  }

  clearCheckout() {
    _selectedVoucher = null;
    _isVoucherUsed = false;

    _log.fine("clear all orders");
    notifyListeners();
  }

  setNetworkError(
    bool status, {
    BuildContext? context,
    String? title,
    Function? then,
  }) {
    if (!_isNetworkError! && status) {
      _isNetworkError = status;
      notifyListeners();
      if (context != null) {
        _isNetworkError = false;
        notifyListeners();
        Navigate.toOfflinePage(
          context,
          title!,
          then: () {
            if (then != null) {
              then();
            }
          },
        );
      }
    } else {
      _isNetworkError = status;
    }
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

  Future<MenuList?> getMenuList(BuildContext context) async {
    if (_isNetworkError!) return null;
    try {
      final _api = Uri.http(host, "$sub/api/menu/all");
      final response = await http
          .get(
            _api,
            headers: await getHeader(),
          )
          .timeout(const Duration(seconds: 4));
      var responseBody = json.decode(response.body);
      if (response.statusCode == 200 && responseBody['status_code'] == 200) {
        _menuList = menuListFromJson(response.body);
        if (_menuList != null) _log.fine("Success get all menu");
        await setNetworkError(false);
        notifyListeners();
        return _menuList;
      }
      return null;
    } on SocketException {
      await setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return null;
    } on TimeoutException {
      await setNetworkError(
        true,
        context: context,
        title: 'Koneksi time out.',
      );
      return null;
    } catch (e) {
      await setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return null;
    }
  }

  // Future<bool> getMenuListDio({id}) async {
  //   try {
  //     var response = await Dio().get('https://$host/api/menu/all');
  //     var data = response.data;
  //     return data != null;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  Future<MenuDetail?> getDetailMenu(
    BuildContext context, {
    required int id,
  }) async {
    if (_isNetworkError!) return null;
    try {
      final _api = Uri.http(host, "$sub/api/menu/detail/$id");
      final response = await http
          .get(_api, headers: await getHeader())
          .timeout(const Duration(seconds: 4));

      var responseBody = json.decode(response.body);
      if (response.statusCode == 200 && responseBody["status_code"] == 200) {
        await setNetworkError(false);
        return menuDetailFromJson(response.body);
      }
      return null;
    } on SocketException {
      await setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return null;
    } on TimeoutException {
      await setNetworkError(
        true,
        context: context,
        title: 'Koneksi time out.',
      );
      return null;
    } catch (e) {
      await setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return null;
    }
  }

  Future<bool> getListVoucher(BuildContext context) async {
    if (_isNetworkError!) return false;
    try {
      final user = UserInstance.getInstance().user;
      if (user == null) return false;
      final _api = Uri.http(host, "$sub/api/voucher/user/${user.data.idUser}");
      final response = await http
          .get(_api, headers: await getHeader())
          .timeout(const Duration(seconds: 4));

      var responseBody = json.decode(response.body);
      if (response.statusCode == 200 && responseBody["status_code"] == 200) {
        _listVoucher = listVoucherFromJson(response.body).data;
        await setNetworkError(false);
        notifyListeners();
        return true;
      }
      return false;
    } on SocketException {
      await setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return false;
    } on TimeoutException {
      await setNetworkError(
        true,
        context: context,
        title: 'Koneksi time out.',
      );
      return false;
    } catch (e) {
      await setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return false;
    }
  }

  Future<bool> getListDisCount(BuildContext context) async {
    if (_isNetworkError!) return false;
    final user = UserInstance.getInstance().user;
    if (user == null) return false;

    try {
      final _api = Uri.http(host, "$sub/api/diskon/user/${user.data.idUser}");

      _log.fine("Try to get list discount");
      final response = await http
          .get(_api, headers: await getHeader())
          .timeout(const Duration(seconds: 4));

      var responseBody = json.decode(response.body);
      if (response.statusCode == 200 && responseBody["status_code"] == 200) {
        _listDiscount = listDiscountFromJson(response.body).data;
        await setNetworkError(false);
        notifyListeners();
        return true;
      }
      return false;
    } on SocketException {
      await setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return false;
    } on TimeoutException {
      await setNetworkError(
        true,
        context: context,
        title: 'Koneksi time out.',
      );
      return false;
    } catch (e) {
      await setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return false;
    }
  }

  Future<bool> getListPromo(BuildContext context) async {
    if (_isNetworkError!) return false;
    final user = UserInstance.getInstance().user;
    if (user == null) return false;

    try {
      final _api = Uri.http(host, "$sub/api/promo/user/${user.data.idUser}");
      final response = await http
          .get(_api, headers: await getHeader())
          .timeout(const Duration(seconds: 4));

      var responseBody = json.decode(response.body);
      if (response.statusCode == 200 && responseBody["status_code"] == 200) {
        _listPromo = listPromoFromJson(response.body).data;
        await setNetworkError(false);
        notifyListeners();
        return true;
      }
      return false;
    } on SocketException {
      await setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return false;
    } on TimeoutException {
      await setNetworkError(
        true,
        context: context,
        title: 'Koneksi time out.',
      );
      return false;
    } catch (e) {
      await setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return false;
    }
  }

  Future<bool> getListOrder(BuildContext context) async {
    if (_isNetworkError!) return false;
    final user = UserInstance.getInstance().user;
    if (user == null) return false;
    try {
      final _api = Uri.http(host, "$sub/api/order/proses/${user.data.idUser}");

      _log.fine("Try to get order in progress");
      final response = await http
          .get(_api, headers: await getHeader())
          .timeout(const Duration(seconds: 4));

      var responseBody = json.decode(response.body);
      if (response.statusCode == 200 && responseBody['status_code'] == 200) {
        _orders = listOrderFromJson(response.body).data;
        await setNetworkError(false);
        notifyListeners();
        return true;
      }
      return false;
    } on SocketException {
      await setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return false;
    } on TimeoutException {
      await setNetworkError(
        true,
        context: context,
        title: 'Koneksi time out.',
      );
      return false;
    } catch (e) {
      await setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return false;
    }
  }

  Future<detail.OrderDetail?> getDetailOrder(
    BuildContext context, {
    required int id,
  }) async {
    if (_isNetworkError!) return null;
    try {
      final _api = Uri.http(host, "$sub/api/order/detail/$id");
      final response = await http
          .get(_api, headers: await getHeader())
          .timeout(const Duration(seconds: 4));

      var responseBody = json.decode(response.body);
      if (response.statusCode == 200 && responseBody["status_code"] == 200) {
        await setNetworkError(false);
        return detail.orderDetailFromJson(response.body);
      }
      return null;
    } on SocketException {
      await setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return null;
    } on TimeoutException {
      await setNetworkError(
        true,
        context: context,
        title: 'Koneksi time out.',
      );
      return null;
    } catch (e) {
      await setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return null;
    }
  }

  Future getTotalHistory(BuildContext context) async {
    if (_isNetworkError!) return null;
    final user = UserInstance.getInstance().user;
    if (user == null) return null;

    try {
      final response = await http
          .get(
            Uri.http(host, '$sub/order/history/total/${user.data.idUser}'),
            headers: await getHeader(),
          )
          .timeout(const Duration(seconds: 4));

      var responseBody = json.decode(response.body);
      if (response.statusCode == 200 && responseBody["status_code"] == 200) {
        await setNetworkError(false);
        return response.body;
      }
      return [];
    } on SocketException {
      await setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return null;
    } on TimeoutException {
      await setNetworkError(
        true,
        context: context,
        title: 'Koneksi time out.',
      );
      return null;
    } catch (e) {
      await setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return null;
    }
  }

  Future<ListHistory?> getHistoryLimit(
    BuildContext context,
    limit,
    start,
    String startDate,
    String endDate,
  ) async {
    if (_isNetworkError!) return null;
    final user = UserInstance.getInstance().user;
    if (user == null) return null;

    try {
      Map<String, dynamic>? request = {
        "limit": limit,
        "offset": start,
        "tanggal": {"startDate": startDate, "endDate": endDate},
      };

      final response = await http
          .post(
            Uri.http(host, '$sub/api/order/history/${user.data.idUser}'),
            body: jsonEncode(request),
            headers: await getHeader(),
          )
          .timeout(const Duration(seconds: 4));

      var responseBody = json.decode(response.body);
      if (response.statusCode == 200 && responseBody['status_code'] == 200) {
        await setNetworkError(false);
        return listHistoryFromJson(response.body);
      }
      return null;
    } on SocketException {
      await setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return null;
    } on TimeoutException {
      await setNetworkError(
        true,
        context: context,
        title: 'Koneksi time out.',
      );
      return null;
    } catch (e) {
      await setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return null;
    }
  }

  Future<List<History>?> getHistoryList(BuildContext context) async {
    if (_isNetworkError!) return null;
    final user = UserInstance.getInstance().user;
    if (user == null) return null;

    try {
      final _api = Uri.http(host, "$sub/api/order/history/${user.data.idUser}");
      final response = await http
          .get(_api, headers: await getHeader())
          .timeout(const Duration(seconds: 4));

      var responseBody = json.decode(response.body);
      if (response.statusCode == 200 && responseBody['status_code'] == 200) {
        await setNetworkError(false);
        return listHistoryFromJson(response.body).data;
      }
      return null;
    } on SocketException {
      await setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return null;
    } on TimeoutException {
      await setNetworkError(
        true,
        context: context,
        title: 'Koneksi time out.',
      );
      return null;
    } catch (e) {
      await setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return null;
    }
  }

  Future<bool> cancelOrder(BuildContext context, {required int idOrder}) async {
    if (_isNetworkError!) return false;
    try {
      final _api = Uri.http(host, "$sub/api/order/batal/$idOrder");
      final response = await http
          .post(_api, headers: await getHeader())
          .timeout(const Duration(seconds: 4));

      var responseBody = json.decode(response.body);
      if (response.statusCode == 200 && responseBody["status_code"] == 200) {
        await setNetworkError(false);
        return true;
      } else {
        showSimpleDialog(
          context,
          responseBody['message'] ?? responseBody['errors']?[0] ?? '',
        );
        return false;
      }
    } on SocketException {
      await setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return false;
    } on TimeoutException {
      await setNetworkError(
        true,
        context: context,
        title: 'Koneksi time out.',
      );
      return false;
    } catch (e) {
      await setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return false;
    }
  }

  Future<bool> sendCheckOut(
    BuildContext context, {
    int? idVoucher,
    List<int>? idDiscount,
    int? discount,
    int? totalPotong,
    required int totalOrder,
    required int totalPay,
    required List<Map<String, dynamic>> menu,
  }) async {
    if (_isNetworkError!) return false;
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

      final response = await http
          .post(
            _api,
            headers: await getHeader(),
            body: jsonEncode(body),
            encoding: Encoding.getByName("utf-8"),
          )
          .timeout(const Duration(seconds: 4));

      var responseBody = json.decode(response.body);
      if (response.statusCode == 200 && responseBody["status_code"] == 200) {
        submitOrder();
        getListOrder(context);

        await setNetworkError(false);
        notifyListeners();
        return true;
      } else {
        showSimpleDialog(
          context,
          responseBody['message'] ?? responseBody['errors']?[0] ?? '',
        );
        return false;
      }
    } on SocketException {
      await setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return false;
    } on TimeoutException {
      await setNetworkError(
        true,
        context: context,
        title: 'Koneksi time out.',
      );
      return false;
    } catch (e) {
      await setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return false;
    }
  }

  setVoucher(LVoucher? data) {
    if (_selectedVoucher == null) {
      _selectedVoucher = data;
    } else {
      if (_selectedVoucher!.idVoucher == data!.idVoucher) {
        _selectedVoucher = data;
      } else {
        _selectedVoucher = data;
        _isVoucherUsed = false;
      }
    }
    notifyListeners();
  }

  setVoucherEmpty() {
    _selectedVoucher = null;
    _isVoucherUsed = false;
    notifyListeners();
  }

  setVoucherUsed(bool? data) {
    _isVoucherUsed = data;
    notifyListeners();
  }
}
