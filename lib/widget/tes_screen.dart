import 'package:flutter/material.dart';

class TesScreen extends StatefulWidget {
  const TesScreen({Key? key}) : super(key: key);

  @override
  State<TesScreen> createState() => _TesScreenState();
}

class _TesScreenState extends State<TesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('This is Test Screen'),
      ),
    );
  }
}
