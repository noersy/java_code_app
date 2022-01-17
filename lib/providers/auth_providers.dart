import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthProviders extends ChangeNotifier {
  static final Uri _api = Uri.https("javacode.ngodingin.com", "/api/auth/login");

  Future<bool> login(String username, String password) async {
    try {

      final body = {
        "username" : username,
        "password" : password
      };

      final response = await http.post(_api, body: body);

      print(response.body);

      final data = json.decode(response.body);

      if(data["status_code"] == 200){
        return true;
      }
    } catch (e) {
      print(e);
      // return false;
    }

    return false;
  }
}
