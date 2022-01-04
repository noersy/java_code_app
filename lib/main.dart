import 'package:flutter/material.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/thame/colors.dart';
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
      create: (BuildContext context)  => OrderProvider(),
      child: MaterialApp(
        title: 'Java Code App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          // primaryColor: ColorSty.primary,
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: ColorSty.primary,
              ),
        ),
        home: LoginPage(),
      ),
    );
  }
}
