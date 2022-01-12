import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code_app/providers/geolocation_providers.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/tools/check_connectivity.dart';
import 'package:java_code_app/widget/button_login.dart';
import 'package:java_code_app/widget/form_login.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final ConnectionStatusSingleton _connectionStatus = ConnectionStatusSingleton.getInstance();
  final _duration = const Duration(seconds: 2);

  bool _loading = false;

  void _navigationPage() {
    setState(() => _loading = true);
    Timer(_duration, checkInternet);
  }

  checkInternet() async {
    // await Provider.of<GeolocationProvider>(context, listen: false).getCurrentPosition();
    final isConnect = await _connectionStatus.checkConnection();
    setState(() => _loading = false);
    if(isConnect )Navigate.toFindLocation(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final safeTopPadding = MediaQuery.of(context).padding.vertical;
    final height = MediaQuery.of(context).size.height;
    return ScreenUtilInit(builder: () {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: height <= 780 ? height + safeTopPadding + 20 : height,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 35.0.w,
                      vertical: 35.0.h,
                    ),
                    child: Image.asset("assert/image/bg_login.png"),
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
                            style: TypoSty.heading.copyWith(fontSize: 20.0.sp),
                          ),
                        ),
                        SizedBox(height: 25.0.h),
                        FormLogin(
                          title: 'Alamat Email',
                          hint: 'Lorem.ipsum@gmail.com',
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
                        SizedBox(height: 25.0.h),
                        ButtonLogin(
                          title: 'Masuk',
                          onPressed: _navigationPage,
                          bgColors: ColorSty.primary,
                        ),
                        SizedBox(height: 40.0.h),
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
                                  horizontal: SpaceDims.sp8),
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
                        SizedBox(height: SpaceDims.sp16.h),
                        ButtonLogin(
                          title: 'Masuk menggunakan',
                          boldTitle: "Google",
                          bgColors: ColorSty.white,
                          icon: "assert/image/icon_google.png",
                          onPressed: () {
                            Provider.of<GeolocationProvider>(context,
                                    listen: false)
                                .getCurrentPosition();
                          },
                        ),
                        SizedBox(height: SpaceDims.sp8.h),
                        ButtonLogin(
                          title: 'Masuk menggunakan',
                          boldTitle: "Apple",
                          icon: "assert/image/icon_apple.png",
                          bgColors: ColorSty.black,
                          onPressed: () {},
                        ),
                        SizedBox(height: SpaceDims.sp22.h)
                      ],
                    ),
                  ),
                  if(_loading) Positioned.fill(
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
