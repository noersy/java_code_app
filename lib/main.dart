import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/thame/colors.dart';
import 'package:java_code_app/view/dashboard_page.dart';
import 'package:java_code_app/view/login_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => OrderProvider(),
      child: ScreenUtilInit(
        builder: () => MaterialApp(
          title: 'Java Code App',
          debugShowCheckedModeBanner: false,
          initialRoute: "/",
          routes: {"dashboard": (_) => const DashboardPage()},
          theme: ThemeData.light().copyWith(
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: ColorSty.primary,
                ),
          ),
          home: LoginPage(),
        ),
      ),
    );
  }
}
