import 'package:flutter/material.dart';
import 'package:java_code_app/thame/spacing.dart';
import 'package:java_code_app/widget/silver_appbar.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({Key? key}) : super(key: key);

  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {

  TextFormField get _search => TextFormField(
    decoration: InputDecoration(
      isDense: true,
      icon: const Icon (Icons.search, size: 26.0,),
      contentPadding: const EdgeInsets.symmetric(vertical: SpaceDims.sp8, horizontal: SpaceDims.sp8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SilverAppBar(
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: SpaceDims.sp12),
        child: _search,
      ),
      floating: true,
      pinned: true,
      body: const Center(child: Text("Texy")),
    );
  }
}
