import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:java_code_app/models/loginuser.dart';
import 'package:java_code_app/models/userdetail.dart';

class AuthProviders extends ChangeNotifier {
  static const String _domain = "javacode.ngodingin.com";
  static LoginUser? _loginUser;
  static UserDetail? _user;

  DUser? user() {
    if(_user != null) return _user!.data;
    return null;
  }

  Future<bool> login(String username, String password) async {
    final Uri _api = Uri.https(_domain, "/api/auth/login");

    try {

      final body = {
        "username" : username,
        "password" : password
      };

      final response = await http.post(_api, body: body);

      // print(response.body);

      final data = json.decode(response.body);
      if(data["status_code"] == 200){
        _loginUser = loginUserFromJson(response.body);
        getUser();
        notifyListeners();
        return true;
      }
    } catch (e) {
      // print(e);
      // return false;
    }

    return false;
  }

  Future<bool> getUser() async {
    if(_loginUser == null ) return false;
    final Uri _api = Uri.https(_domain, "/api/user/detail/${_loginUser!.data.user.idUser}");

    try {
      final headers = {
        "token" : "m_app"
      };

      final response = await http.get(_api, headers: headers);
      print(response.body);

      if(response.statusCode == 200){
        _user = userDetailFromJson(response.body);
        notifyListeners();
        return true;
      }
    } catch (e) {
      // print(e);
      // return false;
    }

    return false;
  }
}
