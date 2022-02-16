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
                        child: Stack(
                      children: [
                        Image.asset("assert/image/bg_daftarpenilaian.png"),
                        ListView(children: [
                          boxChat(context, Alignment.centerRight),
                          boxChat(context, Alignment.centerLeft),
                          boxChat(context, Alignment.centerRight),
                          boxChat(context, Alignment.centerLeft),
                          boxChat(context, Alignment.centerRight),
                          boxChat(context, Alignment.centerLeft),
                        ]),
                      ],
                    ))),
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

  Padding boxChat(BuildContext context, positionBox) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: positionBox,
        child: Container(
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
                color: Color.fromRGBO(223, 239, 241, 0.5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                )),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, right: 20.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '05.05 pm',
                            textAlign: TextAlign.right,
                          ),
                          Icon(Icons.person)
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 20.0,
                    left: 20.0,
                    bottom: 20.0,
                  ),
                  child: Text(
                    'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available',
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
