// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:java_code_app/constans/key_prefens.dart';
import 'package:java_code_app/providers/auth_providers.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/singletons/shared_preferences.dart';
import 'package:java_code_app/widget/button/button_login.dart';
import 'package:java_code_app/widget/dialog/custom_dialog.dart';
import 'package:java_code_app/widget/input/form_login.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  // final ConnectionStatus _connectionStatus = ConnectionStatus.getInstance();
  final Preferences _preferences = Preferences.getInstance();
  final _duration = const Duration(seconds: 1);

  bool _loading = false;

  _login() async {
    setState(() => _loading = true);
    Map loginResponse =
        await Provider.of<AuthProviders>(context, listen: false).login(
      context,
      _controllerEmail.text,
      _controllerPassword.text,
      isGoogle: false,
    );

    if (loginResponse['status']) {
      await _preferences.setBoolValue(KeyPrefens.login, true);

      Timer(_duration, () {
        Navigate.toDashboard(context);
        setState(() => _loading = false);
      });
      return;
    } else {
      showSimpleDialog(context, loginResponse['message']);
      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       return AlertDialog(
      //         title: const Text(
      //             'Email/password anda salah!\nAnda belum mendaftar?'),
      //         // content: Text('email '),
      //         actions: <Widget>[
      //           TextButton(
      //               onPressed: () {
      //                 Navigator.pop(context);
      //               },
      //               child: const Text('Close')),
      //         ],
      //       );
      //     });
    }

    setState(() => _loading = false);
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  _loginWithGoogle() async {
    setState(() => _loading = true);
    if (_googleSignIn.currentUser != null) await _googleSignIn.disconnect();
    Map isLogin =
        await Provider.of<AuthProviders>(context, listen: false).login(
      context,
      _googleSignIn.currentUser!.email,
      '',
      isGoogle: true,
      nama: _googleSignIn.currentUser?.displayName,
    );
    if (isLogin['status']) {
      await _preferences.setBoolValue(KeyPrefens.login, true);

      Timer(_duration, () {
        Navigate.toFindLocation(context);
        setState(() => _loading = false);
      });
      return;
    } else {
      showSimpleDialog(context, isLogin['message']);
    }

    setState(() => _loading = false);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final safeTopPadding = MediaQuery.of(context).padding.vertical;
    final height = MediaQuery.of(context).size.height;
    return ScreenUtilInit(builder: () {
      return Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: height <= 780 ? height + safeTopPadding + 20 : height,
            child: SingleChildScrollView(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned.fill(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 35.0.w,
                        vertical: 35.0.h,
                      ),
                      child: Image.asset("assert/image/bg_login.png"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.0.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: 70.0.h),
                        Image.asset("assert/image/javacode_logo.png"),
                        SizedBox(height: 80.0.h),
                        SizedBox(
                          width: 339.0.w,
                          child: Text(
                            'Masuk untuk melanjutkan!',
                            style: TypoSty.heading.copyWith(fontSize: 18.0.sp),
                          ),
                        ),
                        SizedBox(height: 25.0.h),
                        FormLogin(
                          title: 'Alamat Email',
                          hint: 'example.email@gmail.com',
                          type: TextInputType.emailAddress,
                          editingController: _controllerEmail,
                        ),
                        SizedBox(height: 25.0.h),
                        FormLogin(
                          title: 'Kata Sandi',
                          hint: '****************',
                          type: TextInputType.visiblePassword,
                          editingController: _controllerPassword,
                        ),
                        SizedBox(height: 10.0.h),
                        ButtonLogin(
                          title: 'Masuk',
                          onPressed: _login,
                          bgColors: ColorSty.primary,
                        ),
                        SizedBox(height: 5.0.h),
                        Row(
                          children: [
                            const Expanded(
                              child: DecoratedBox(
                                decoration: BoxDecoration(color: ColorSty.grey),
                                child: SizedBox(height: 1),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: SpaceDims.sp2),
                              child: Text("atau", style: TypoSty.caption2),
                            ),
                            const Expanded(
                              child: DecoratedBox(
                                decoration: BoxDecoration(color: ColorSty.grey),
                                child: SizedBox(height: 1),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: SpaceDims.sp6.h),
                        //kalau devices android
                        if (Platform.isAndroid)
                          ButtonLogin(
                            title: 'Masuk menggunakan',
                            boldTitle: "Google",
                            bgColors: ColorSty.white,
                            icon: "assert/image/icon_google.png",
                            onPressed: _loginWithGoogle,
                          ),
                        SizedBox(height: SpaceDims.sp8.h),
                        //kalau device ios
                        if (Platform.isIOS)
                          ButtonLogin(
                            title: 'Masuk menggunakan',
                            boldTitle: "Apple",
                            icon: "assert/image/icon_apple.png",
                            bgColors: ColorSty.black,
                            onPressed: () async {
                              final credential =
                                  await SignInWithApple.getAppleIDCredential(
                                scopes: [
                                  AppleIDAuthorizationScopes.email,
                                  AppleIDAuthorizationScopes.fullName,
                                ],
                              );
                              // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
                              // after they have been validated with Apple (see `Integration` section for more information on how to do this)
                            },
                          ),
                        SizedBox(height: SpaceDims.sp22.h)
                      ],
                    ),
                  ),
                  if (_loading)
                    Positioned.fill(
                      child: Container(
                        alignment: Alignment.center,
                        color: ColorSty.white.withOpacity(0.3),
                        child: const RefreshProgressIndicator(),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
