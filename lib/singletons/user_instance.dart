
import 'package:java_code_app/models/userdetail.dart';

class UserInstance {
  //This creates the single instance by calling the `_internal` constructor specified below
  static final UserInstance _singleton = UserInstance._internal();
  UserInstance._internal();

  //This is what's used to retrieve the instance through the app
  static UserInstance getInstance() => _singleton;
  
  static UserDetail? _userDetail;

  //And check the connection status out of the gate
  void initialize(UserDetail user) {
    _userDetail = user;
    print("User has initialize");
  }

  UserDetail? get user => _userDetail;
}