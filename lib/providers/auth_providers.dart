import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:java_code_app/constans/hosts.dart';
import 'package:java_code_app/constans/key_prefens.dart';
import 'package:java_code_app/models/loginuser.dart';
import 'package:java_code_app/models/userdetail.dart';
import 'package:java_code_app/singletons/shared_preferences.dart';
import 'package:java_code_app/singletons/user_instance.dart';

class AuthProviders extends ChangeNotifier {
  static LoginUser? _loginUser;
  static UserDetail? _user;

  DUser? user() {
    if (_user != null) return _user!.data;
    return null;
  }

  Future<bool> login(
    String email,
    String? password, {
    bool? isGoogle = false,
    String? nama = "",
  }) async {
    final Uri _api = Uri.http(host, "$sub/api/auth/login");
    try {
      final body = <String, dynamic>{
        "email": email,
        "password": password,
        "nama": nama,
        "is_google": isGoogle! ? "is_google" : "",
      };

      final response = await http.post(_api, body: body);

      if (response.statusCode == 200) {
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
    final user = UserInstance.getInstance().user;
    if (user == null) return false;
    final _id = user.data.idUser;
    final Uri _api = Uri.http(host, "$sub/api/user/detail/$_id");

    try {
      final headers = {"token": "m_app"};

      final response = await http.get(_api, headers: headers);

      // print(response.body);

      if (response.statusCode == 200) {
        _user = userDetailFromJson(response.body);
        UserInstance.getInstance().initialize(_user!);
        notifyListeners();
        return true;
      }
    } catch (e) {
      // print(e);
      // return false;
    }

    return false;
  }


  Future<bool> update({id, key, value}) async {
    final user = UserInstance.getInstance().user;
    if (user == null) return false;
    final _id = user.data.idUser;
    final Uri _api = Uri.http(host, "$sub/api/user/update/$_id");

    try {
      final headers = {"token": "m_app"};
      final body = {"$key" : "$value"};
      final response = await http.post(_api, headers: headers, body: body);

      if (response.statusCode == 200) {
        getUser();
        return true;
      }
    } catch (e) {
      // return false;
    }
    return false;
  }

  Future<bool> uploadProfileImage(String base64) async {
    final user = UserInstance.getInstance().user;

    if(user == null) return false;
    final Uri _api = Uri.http(host, "$sub/api/user/profil/${user.data.idUser}");

    try {
      final headers = {
        "Content-Type" : "application/json",
        "token": "m_app",
      };
      final body = {"image" : base64};
      final response = await http.post(
          _api,
          headers: headers,
          body: jsonEncode(body),
      );

      print(response.body);

      if (response.statusCode == 200) {
        getUser();
        return true;
      }
    } catch (e) {
      // return false;
    }
    return false;
  }
}
