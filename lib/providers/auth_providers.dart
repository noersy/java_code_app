import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthProviders extends ChangeNotifier {
  static final Uri _api = Uri.http("192.168.1.35:8080", "landa_db/api/site/login");

  Future<bool> login() async {
    try {

      final body = {
        "username" : "admin",
        "password" : "admin"
      };

      final response = await http.post(_api, body: body);

      // print(response.body);

      if(response.statusCode == 200){
        return true;
      }
    } catch (e) {
      // print(e);
      // return false;
    }

    return false;
  }
}
