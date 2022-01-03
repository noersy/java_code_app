import 'package:flutter/material.dart';
import 'package:java_code_app/widget/silver_appbar.dart';

class PromoPage extends StatelessWidget {
  const PromoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SilverAppBar(
        floating: true,
        pinned: true,
        title: const Text("null"),
        body: Container(),
      ),
    );
  }
}
