import 'package:flutter/material.dart';
import 'package:java_code_app/providers/lang_providers.dart';
import 'package:java_code_app/widget/appbar/appbar.dart';

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
          return Scaffold(
            backgroundColor: Color.fromARGB(255, 229, 229, 229),
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
                // color: Color.fromARGB(255, 98, 97, 97),
                child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0),
                        )),
                    child: Center(
                        child: Image.asset(
                            "assert/image/bg_daftarpenilaian.png"))),
              ),
            ),
            bottomNavigationBar: Container(
              // height: MediaQuery.of(context).viewInsets.bottom,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  )),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 10.0,
                          right: 5,
                          top: 5,
                          bottom: MediaQuery.of(context).viewInsets.bottom + 5),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                              bottomLeft: Radius.circular(40.0),
                              bottomRight: Radius.circular(40.0),
                            )),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 8.0,
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: 'Name'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: 10,
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: ElevatedButton(
                        onPressed: () {}, child: Icon(Icons.send)),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
