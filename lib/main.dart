import 'package:flutter/material.dart';
import 'package:java_code_app/view/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Java Code App',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
