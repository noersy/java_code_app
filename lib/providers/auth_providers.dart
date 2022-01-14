import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthProviders extends ChangeNotifier {
  static final Uri _api = Uri.http("192.168.1.35:8080", "/landa_db/api/auth/login");

  Future<bool> login(String username, String password) async {
    try {

      final body = {
        "username" : username,
        "password" : password
      };

      final response = await http.post(_api, body: body);

      print(response.body);

      if(response.statusCode == 200){
        return true;
      }
    } catch (e) {
      print(e);
      // return false;
    }

    return false;
  }
}
