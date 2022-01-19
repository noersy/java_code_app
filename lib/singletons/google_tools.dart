import 'package:google_sign_in/google_sign_in.dart';

class GoogleLogin {
  //This creates the single instance by calling the `_internal` constructor specified below
  static final GoogleLogin _singleton = GoogleLogin._internal();

  GoogleLogin._internal();

  //This is what's used to retrieve the instance through the app
  static GoogleLogin getInstance() => _singleton;

  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<GoogleSignInAccount?> login() async {
    try {
      return await _googleSignIn.signIn();
    } catch (e) {}
    return null;
  }

  Future<GoogleSignInAccount?> logout() async {
    try {
      return await _googleSignIn.signOut();
    } catch (e) {}
    return null;
  }
}
