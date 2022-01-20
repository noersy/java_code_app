import 'package:flutter/material.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';

class OfflinePage extends StatelessWidget {
  const OfflinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.signal_wifi_off,
              color: Colors.grey,
              size: 52.0,
            ),
            const SizedBox(height: SpaceDims.sp24),
            Text(
              "Koneksi anda terputus.",
              style: TypoSty.title.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
