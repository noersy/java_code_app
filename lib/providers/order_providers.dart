import 'package:flutter/cupertino.dart';
import 'package:java_code_app/models/menulist.dart';
import 'package:java_code_app/tools/random_string.dart';
import 'package:http/http.dart' as http;


class OrderProviders extends ChangeNotifier {
  // static int _orderInProgress = 0;
  // static int _checkOrder = 0;
  static const String _domain = "192.168.1.35:8080";

  static Map<String, dynamic> _checkOrder = {};
  static List<Map<String, dynamic>> _orderInProgress = [];

  Map<String, dynamic> get checkOrder => _checkOrder;
  List<Map<String, dynamic>> get orderProgress => _orderInProgress;

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

  submitOrder(Map<String, dynamic>? voucher) async {
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

  Future<MenuList?> getMenuList() async{
      try {
        final _api = Uri.http("192.168.1.35:8080", "/landa_db/api/menu");

        final response = await http.get(_api);

        print(response.body);

        if(response.statusCode == 200){
          final MenuList data = menuListFromJson(response.body);
          print(data.data.length);

          return menuListFromJson(response.body);
        }
        return null;
      } catch (e) {
        return null;
      }
    }
}
