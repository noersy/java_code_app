import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:java_code_app/constans/key_prefens.dart';
import 'package:java_code_app/models/loginuser.dart';
import 'package:java_code_app/models/userdetail.dart';
import 'package:java_code_app/tools/shared_preferences.dart';

class AuthProviders extends ChangeNotifier {
  static const String _domain = "javacode.ngodingin.com";
  static LoginUser? _loginUser;
  static UserDetail? _user;
  
  DUser? user() {
    if(_user != null) return _user!.data;
    return null;
  }

  Future<bool> login(String email, String password) async {
    final Uri _api = Uri.https(_domain, "/api/auth/login");
    try {

      final body = {
        "email" : email,
        "password" : password
      };

      final response = await http.post(_api, body: body);

      // print(response.body);

      final data = json.decode(response.body);
      if(data["status_code"] == 200){
        _loginUser = loginUserFromJson(response.body);
        Preferences.getInstance().setIntValue(KeyPrefens.loginID, _loginUser!.data.user.idUser);
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

  Future<bool> getUser({id}) async {
    if(_loginUser == null && id == null) return false;
    final _id = id ?? _loginUser!.data.user.idUser; 
    final Uri _api = Uri.https(_domain, "/api/user/detail/$_id");

    try {
      final headers = {
        "token" : "m_app"
      };

      final response = await http.get(_api, headers: headers);

      if(response.statusCode == 200){
        print(response.body);
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
