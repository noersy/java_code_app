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
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // height: 300.0,
                // height: MediaQuery.of(context).size.height / 1.3,
                color: Colors.transparent,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0),
                        )),
                    child: Center(
                      child: Text("Hi modal sheet"),
                    )),
              ),
            ),
            bottomNavigationBar: ConstrainedBox(
                constraints: BoxConstraints.tight(const Size(200, 50)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(hintText: 'Name'),
                      ),
                    ),
                    ElevatedButton(onPressed: () {}, child: Icon(Icons.send)),
                  ],
                )),
          );
        });
  }
}
