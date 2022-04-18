// ignore_for_file: prefer_adjacent_string_concatenation

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:java_code_app/constans/gettoken.dart';
import 'package:java_code_app/constans/hosts.dart';
import 'package:java_code_app/constans/key_prefens.dart';
import 'package:java_code_app/models/loginuser.dart';
import 'package:java_code_app/models/userdetail.dart';
import 'package:java_code_app/singletons/shared_preferences.dart';
import 'package:java_code_app/singletons/user_instance.dart';
import 'package:logging/logging.dart';

class AuthProviders extends ChangeNotifier {
  static LoginUser? _loginUser;
  static UserDetail? _user;
  static final _log = Logger('AuthProvider');

  DUser? user() {
    if (_user != null) return _user!.data;
    return null;
  }

  Future<Map> login(
    String email,
    String? password, {
    bool? isGoogle = false,
    String? nama = "",
  }) async {
    // ignore: prefer_typing_uninitialized_variables
    var editResponse;
    final Uri _api = Uri.http(host, "$sub/api/auth/login");
    try {
      final body = <String, dynamic>{
        "email": email,
        "password": password,
      };

      _log.fine("Tray to login." + '\n$email' + '\n$password');
      final response = await http.post(
        _api,
        body: body,
      );
      if (response.statusCode == 200 &&
          json.decode(response.body)["status_code"] == 200) {
        editResponse = jsonDecode(response.body);
        if (json.decode(response.body)["data"]["user"]["foto"] == null) {
          editResponse["data"]["user"]["foto"] =
              '''https://javacode.landa.id/img/1/review/review_1_620e0269b96d2.png''';
          // editResponse = json.encode(editResponse);
        }
        Preferences.getInstance().setStringValue(
          'token',
          editResponse['data']['token'].toString(),
        );
        _loginUser = loginUserFromJson(editResponse);
        if (_loginUser == null) _log.info("Login failed");
        if (_loginUser != null) _log.fine("Login successes");

        Preferences.getInstance()
            .setIntValue(KeyPrefens.loginID, _loginUser!.data.user.idUser);
        _user = userDetailFromJson2(json.encode(editResponse['data']['user']));
        UserInstance.getInstance().initialize(user: _user);
        // getUser(id: _loginUser!.data.user.idUser);
        notifyListeners();
        if (_loginUser != null) {
          return {
            'status': true,
            'message': 'Login Berhasil',
          };
        } else {
          return {
            'status': true,
            'message': editResponse['errors'] != null
                ? editResponse['errors'][0]
                : editResponse['message'] ?? 'Login gagal',
          };
        }
      }
    } catch (e, r) {
      _log.warning(e);
      _log.warning(r);
    }
    return {
      'status': true,
      'message': 'Login gagal',
    };
  }

  Future<bool> loginGoogle(
    String email, {
    bool? isGoogle = true,
    String? nama = "",
  }) async {
    // ignore: prefer_typing_uninitialized_variables
    var editResponse;
    final Uri _api = Uri.http(host, "$sub/api/auth/login");
    try {
      final body = <String, dynamic>{
        "email": email,
        "nama": nama,
        "is_google": isGoogle! ? "is_google" : "",
      };

      _log.fine("Tray to login." + '\n$email' + '\n$nama');
      final response = await http.post(
        _api,
        headers: await getHeader(),
        body: body,
      );
      if (response.statusCode == 200 &&
          json.decode(response.body)["status_code"] == 200) {
        editResponse = json.decode(response.body);
        if (json.decode(response.body)["data"]["user"]["foto"] == null) {
          editResponse["data"]["user"]["foto"] =
              '''https://javacode.landa.id/img/1/review/review_1_620e0269b96d2.png''';
          editResponse = json.encode(editResponse);
        }
        if (json.decode(response.body)["data"]["user"]["foto"] != null) {
          editResponse = json.encode(editResponse);
        }
        _loginUser = loginUserFromJson(editResponse);
        if (_loginUser == null) _log.info("Login failed");
        if (_loginUser != null) _log.fine("Login successes");

        Preferences.getInstance()
            .setIntValue(KeyPrefens.loginID, _loginUser!.data.user.idUser);
        getUser(id: _loginUser!.data.user.idUser);
        notifyListeners();
        if (_loginUser != null) {
          return true;
        } else {
          return false;
        }
      }
    } catch (e, r) {
      _log.warning(e);
      _log.warning(r);
    }
    return false;
  }

  // Future<bool> loginDio(
  //   String email,
  //   String? password, {
  //   bool? isGoogle = false,
  //   String? nama = "",
  // }) async {
  //   final body = <String, dynamic>{
  //     "email": email,
  //     "password": password,
  //     "nama": nama,
  //     "is_google": isGoogle! ? "is_google" : "",
  //   };
  //   try {
  //     var response = await Dio().post(
  //       'https://$host/api/auth/login',
  //       data: jsonEncode(body),
  //     );
  //     var data = response.data;
  //     return data != null;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  Future<bool> getUserDio({id}) async {
    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    String? token = await Preferences.getInstance().getStringValue('token');
    dio.options.headers['token'] = token;
    try {
      var response = await dio.get('https://$host/api/user/detail/$id');
      var data = response.data;
      return data != null;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getUser({id}) async {
    final user = UserInstance.getInstance().user;
    if (user == null && id == null) return false; //@todo make new exception

    final _id = id ?? user!.data.idUser;
    final Uri _api = Uri.http(host, "$sub/api/user/detail/$_id");

    try {
      _log.fine("Tray to get data user.");
      final response = await http.get(_api, headers: await getHeader()).timeout(
        const Duration(seconds: 4),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );

      if (response.statusCode == 200 &&
          json.decode(response.body)["status_code"] == 200) {
        _user = userDetailFromJson(response.body);
        if (_user == null) _log.info("Failed get data user.");
        if (_user != null) _log.fine("Success get data user.");
        UserInstance.getInstance().initialize(user: _user!);
        notifyListeners();
        return true;
      }
    } catch (e, r) {
      _log.warning(e);
      _log.warning(r);
    }

    return false;
  }

  Future<bool> update({id, key, value}) async {
    final user = UserInstance.getInstance().user;
    if (user == null) return false;

    final _id = user.data.idUser;
    final Uri _api = Uri.http(host, "/api/user/update/$_id");
    try {
      final body = jsonEncode({"$key": "$value"});

      _log.fine("Tray update user profile.");
      final response =
          await http.post(_api, headers: await getHeader(), body: body);
      if (response.statusCode == 200 &&
          json.decode(response.body)["status_code"] == 200) {
        _log.fine("Success update $key user.");
        getUser();
        return true;
      }
    } catch (e, r) {
      _log.warning(e);
      _log.warning(r);
    }
    return false;
  }

  Future<bool> uploadProfileImage(String base64) async {
    final user = UserInstance.getInstance().user;

    if (user == null) return false;

    final Uri _api = Uri.http(
      host,
      "$sub/api/user/profil/${user.data.idUser}",
    );

    try {
      final body = {"image": base64};

      _log.fine("Try update profile image.\n$base64");
      final response = await http.post(
        _api,
        headers: await getHeader(),
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 &&
          json.decode(response.body)["status_code"] == 200) {
        if (_user == null) _log.info("Failed Upload profile image.");
        getUser();
        return true;
      }
    } catch (e) {
      // return false;
    }
    return false;
  }

  Future<bool> uploadKtp(String base64) async {
    final user = UserInstance.getInstance().user;

    if (user == null) return false;
    final Uri _api = Uri.http(host, "$sub/api/user/ktp/${user.data.idUser}");

    try {
      final body = {"image": base64};

      _log.fine("Tray upload ktp");
      final response = await http.post(
        _api,
        headers: await getHeader(),
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 &&
          json.decode(response.body)["status_code"] == 200) {
        _log.fine("Successes upload ktp");
        getUser();
        return true;
      }
    } catch (e, r) {
      _log.warning(e);
      _log.warning(r);
    }
    return false;
  }
}
