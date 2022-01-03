import 'package:flutter/material.dart';

class FindLocationPage extends StatelessWidget {
  const FindLocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: Image.asset('assert/image/bg_findlocation.png'),
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
