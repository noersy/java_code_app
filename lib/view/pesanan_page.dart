import 'package:flutter/material.dart';
import 'package:java_code_app/widget/silver_appbar.dart';

class PesananPage extends StatefulWidget {
  const PesananPage({Key? key}) : super(key: key);

  @override
  _PesananPageState createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {
  @override
  Widget build(BuildContext context) {
    return SilverAppBar(
      title: AppBar(),
      floating: true,
      pinned: true,
      body: Container(),
    );
  }
}
