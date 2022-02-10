import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:java_code_app/providers/lang_providers.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/widget/appbar/appbar.dart';
import 'package:provider/provider.dart';

class BalasanReview extends StatefulWidget {
  const BalasanReview({Key? key}) : super(key: key);

  @override
  _BalasanReviewState createState() => _BalasanReviewState();
}

class _BalasanReviewState extends State<BalasanReview> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: LangProviders(),
        builder: (context, snapshot) {
          final lang = Provider.of<LangProviders>(context).lang;
          return Scaffold(
            appBar: const CostumeAppBar(
              title: '',
              profileTitle: 'BalasanReview',
              // profileTitle: lang.profile.title,
              back: true,
            ),
            body: Stack(
              children: [
                Image.asset("assert/image/bg_daftarpenilaian.png"),
              ],
            ),
          );
        });
  }
}
