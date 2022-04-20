// ignore_for_file: prefer_adjacent_string_concatenation

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:java_code_app/constans/gettoken.dart';
import 'package:java_code_app/constans/hosts.dart';
import 'package:java_code_app/constans/key_prefens.dart';
import 'package:java_code_app/models/loginuser.dart';
import 'package:java_code_app/models/userdetail.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/singletons/shared_preferences.dart';
import 'package:java_code_app/singletons/user_instance.dart';
import 'package:java_code_app/widget/dialog/custom_dialog.dart';
import 'package:provider/provider.dart';

class AuthProviders extends ChangeNotifier {
  static LoginUser? _loginUser;
  static UserDetail? _user;

  DUser? user() {
    if (_user != null) return _user!.data;
    return null;
  }

  Future<Map> login(
    BuildContext context,
    String email,
    String? password, {
    bool? isGoogle = false,
    String? nama = "",
  }) async {
    // ignore: prefer_typing_uninitialized_variables
    OrderProviders orderProviders =
        Provider.of<OrderProviders>(context, listen: false);

    if (orderProviders.isNetworkError!) {
      return {
        'status': false,
        'message': 'Login gagal',
      };
    }

    try {
      final Uri _api = Uri.http(host, "$sub/api/auth/login");

      final body = <String, dynamic>{
        "email": email,
        "password": password,
        "nama": nama,
        "is_google": isGoogle! ? "is_google" : "",
      };

      final response = await http
          .post(
            _api,
            body: body,
          )
          .timeout(
            const Duration(seconds: 4),
          );

      var editResponse = json.decode(response.body);
      if (response.statusCode == 200 && editResponse["status_code"] == 200) {
        orderProviders.setNetworkError(false);
        Preferences.getInstance().setStringValue(
          'token',
          editResponse['data']['token'].toString(),
        );
        _loginUser = loginUserFromJson(editResponse);

        Preferences.getInstance()
            .setIntValue(KeyPrefens.loginID, _loginUser!.data.user.idUser);
        _user = userDetailFromJson2(json.encode(editResponse['data']['user']));
        UserInstance.getInstance().initialize(user: _user);
        orderProviders.setNetworkError(false);
        notifyListeners();

        if (_loginUser != null) {
          return {
            'status': true,
            'message': 'Login Berhasil',
          };
        }
      } else {
        return {
          'status': false,
          'message': editResponse['errors'] != null
              ? editResponse['errors'][0]
              : editResponse['message'] ?? 'Login gagal',
        };
      }
    } on SocketException {
      orderProviders.setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );

      return {
        'status': false,
        'message': 'Login gagal',
      };
    } on TimeoutException {
      orderProviders.setNetworkError(
        true,
        context: context,
        title: 'Koneksi time out.',
      );
      return {
        'status': false,
        'message': 'Login gagal',
      };
    } catch (e) {
      orderProviders.setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return {
        'status': false,
        'message': 'Login gagal',
      };
    }
    return {
      'status': false,
      'message': 'Login gagal',
    };
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

  Future<bool> getUser(BuildContext context, {id}) async {
    OrderProviders orderProviders =
        Provider.of<OrderProviders>(context, listen: false);
    if (orderProviders.isNetworkError!) return false;

    final user = UserInstance.getInstance().user;
    if (user == null && id == null) return false;

    final _id = id ?? user!.data.idUser;
    final Uri _api = Uri.http(host, "$sub/api/user/detail/$_id");

    try {
      final response = await http.get(_api, headers: await getHeader()).timeout(
            const Duration(seconds: 4),
          );

      var responseBody = json.decode(response.body);

      if (response.statusCode == 200 && responseBody["status_code"] == 200) {
        orderProviders.setNetworkError(false);
        _user = userDetailFromJson(response.body);
        UserInstance.getInstance().initialize(user: _user!);
        orderProviders.setNetworkError(false);
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
      orderProviders.setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return false;
    } on TimeoutException {
      orderProviders.setNetworkError(
        true,
        context: context,
        title: 'Koneksi time out.',
      );
      return false;
    } catch (e) {
      orderProviders.setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return false;
    }
  }

  Future<Map> update(BuildContext context, {id, key, value}) async {
    OrderProviders orderProviders =
        Provider.of<OrderProviders>(context, listen: false);
    if (orderProviders.isNetworkError!) {
      return {
        'status': false,
        'message': 'Update gagal',
      };
    }

    final user = UserInstance.getInstance().user;
    if (user == null) {
      return {
        'status': false,
        'message': 'Login gagal',
      };
    }

    final _id = user.data.idUser;
    final Uri _api = Uri.http(host, "/api/user/update/$_id");
    try {
      final body = jsonEncode({"$key": "$value"});
      final response =
          await http.post(_api, headers: await getHeader(), body: body).timeout(
                const Duration(seconds: 4),
              );

      var responseBody = json.decode(response.body);
      if (response.statusCode == 200 && responseBody["status_code"] == 200) {
        orderProviders.setNetworkError(false);
        getUser(context);
        return {
          'status': true,
          'message': 'Update sukses',
        };
      } else {
        return {
          'status': false,
          'message': responseBody['errors'] != null
              ? responseBody['errors'][0]
              : responseBody['message'] ?? 'Login gagal',
        };
      }
    } on SocketException {
      orderProviders.setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return {
        'status': false,
        'message': 'Update gagal',
      };
    } on TimeoutException {
      orderProviders.setNetworkError(
        true,
        context: context,
        title: 'Koneksi time out.',
      );
      return {
        'status': false,
        'message': 'Update gagal',
      };
    } catch (e) {
      orderProviders.setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return {
        'status': false,
        'message': 'Update gagal',
      };
    }
  }

  Future<Map> uploadProfileImage(BuildContext context, String base64) async {
    OrderProviders orderProviders =
        Provider.of<OrderProviders>(context, listen: false);
    if (orderProviders.isNetworkError!) {
      return {
        'status': false,
        'message': 'Update gagal',
      };
    }

    final user = UserInstance.getInstance().user;
    if (user == null) {
      return {
        'status': false,
        'message': 'Update gagal',
      };
    }

    try {
      final Uri _api = Uri.http(
        host,
        "$sub/api/user/profil/${user.data.idUser}",
      );
      final body = {"image": base64};

      final response = await http
          .post(
            _api,
            headers: await getHeader(),
            body: jsonEncode(body),
          )
          .timeout(
            const Duration(seconds: 4),
          );

      var responseBody = json.decode(response.body);
      if (response.statusCode == 200 && responseBody["status_code"] == 200) {
        orderProviders.setNetworkError(false);
        getUser(context);
        return {
          'status': true,
          'message': 'Update sukses',
        };
      } else {
        return {
          'status': false,
          'message': responseBody['errors'] != null
              ? responseBody['errors'][0]
              : responseBody['message'] ?? 'Login gagal',
        };
      }
    } on SocketException {
      orderProviders.setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return {
        'status': false,
        'message': 'Update gagal',
      };
    } on TimeoutException {
      orderProviders.setNetworkError(
        true,
        context: context,
        title: 'Koneksi time out.',
      );
      return {
        'status': false,
        'message': 'Update gagal',
      };
    } catch (e) {
      orderProviders.setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return {
        'status': false,
        'message': 'Update gagal',
      };
    }
  }

  Future<Map> uploadKtp(BuildContext context, String base64) async {
    OrderProviders orderProviders =
        Provider.of<OrderProviders>(context, listen: false);
    if (orderProviders.isNetworkError!) {
      return {
        'status': false,
        'message': 'Update gagal',
      };
    }

    final user = UserInstance.getInstance().user;
    if (user == null) {
      return {
        'status': false,
        'message': 'Update gagal',
      };
    }

    try {
      final Uri _api = Uri.http(
        host,
        "$sub/api/user/ktp/${user.data.idUser}",
      );
      final body = {"image": base64};

      final response = await http
          .post(
            _api,
            headers: await getHeader(),
            body: jsonEncode(body),
          )
          .timeout(
            const Duration(seconds: 4),
          );

      var responseBody = json.decode(response.body);
      if (response.statusCode == 200 && responseBody["status_code"] == 200) {
        orderProviders.setNetworkError(false);
        getUser(context);
        orderProviders.setNetworkError(false);
        return {
          'status': true,
          'message': 'Update sukses',
        };
      } else {
        return {
          'status': false,
          'message': responseBody['errors'] != null
              ? responseBody['errors'][0]
              : responseBody['message'] ?? 'Login gagal',
        };
      }
    } on SocketException {
      orderProviders.setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return {
        'status': false,
        'message': 'Update gagal',
      };
    } on TimeoutException {
      orderProviders.setNetworkError(
        true,
        context: context,
        title: 'Koneksi time out.',
      );
      return {
        'status': false,
        'message': 'Update gagal',
      };
    } catch (e) {
      orderProviders.setNetworkError(
        true,
        context: context,
        title: 'Terjadi masalah dengan server.',
      );
      return {
        'status': false,
        'message': 'Update gagal',
      };
    }
  }
}
