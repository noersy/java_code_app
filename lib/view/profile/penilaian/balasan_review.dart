import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:java_code_app/providers/lang_providers.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/widget/appbar/appbar.dart';

import 'get_all_chat.dart';

class BalasanReview extends StatefulWidget {
  final idReview;
  BalasanReview({Key? key, this.idReview}) : super(key: key);

  @override
  _BalasanReviewState createState() => _BalasanReviewState();
}

class _BalasanReviewState extends State<BalasanReview> {
  List listBoxChat = [
    true,
    false,
  ];
  loadChat() {
    listChat.clear();
    Future data = getAllChat(widget.idReview);
    data.then((value) {
      Map json = jsonDecode(value);
      // print('json: ${json['data']}');
      var jsonData = json['data'];
      // var getidReview = jsonData['review'];
      // print('getidReview ${getidReview['id_review']}');
      for (var i in jsonData['answer']) {
        // print('i: $i');
        Answer ans = Answer.fromJson(i);
        listChat.add(ans);
      }
      setState(() {
        widgetListChat();
        // idReview = getidReview['id_review'];
      });
    });
  }

  sendChat(answer, idReview) {
    Future data = postChat(answer, idReview);
    data.then((value) {
      loadChat();
      print('value post chat: $value');
    });
  }

  @override
  void initState() {
    loadChat();
    super.initState();
  }

  TextEditingController _pesanController = TextEditingController();
  AppBar widgetAppBar() {
    return AppBar(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        )),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: ColorSty.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Balasan Review',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: LangProviders(),
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Color.fromARGB(255, 229, 229, 229),
            appBar: widgetAppBar(),
            body: Container(
              child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(40.0),
                    //   topRight: Radius.circular(40.0),
                    //   bottomLeft: Radius.circular(40.0),
                    //   bottomRight: Radius.circular(40.0),
                    // )
                  ),
                  child: Center(
                      child: Stack(
                    children: [
                      Image.asset("assert/image/bg_daftarpenilaian.png"),
                      widgetListChat(),
                    ],
                  ))),
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(30.0),
                //   topRight: Radius.circular(30.0),
                // )
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 18.0,
                          top: 5,
                          bottom:
                              MediaQuery.of(context).viewInsets.bottom + 10),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(46, 46, 46, 0.25)),
                            color: Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                              bottomLeft: Radius.circular(40.0),
                              bottomRight: Radius.circular(40.0),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 15.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _pesanController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Tulis Pesan ...'),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon:
                                      Icon(Icons.add_photo_alternate_outlined)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          right: 15,
                          bottom: MediaQuery.of(context).viewInsets.bottom + 5),
                      child: IconButton(
                        onPressed: () {
                          print(
                              'pesan: ${_pesanController.text} | id review: ${widget.idReview}');
                          sendChat(_pesanController.text, widget.idReview);
                          _pesanController.clear();
                        },
                        icon: Icon(Icons.send),
                        color: Color.fromRGBO(0, 154, 173, 1),
                      )),
                ],
              ),
            ),
          );
        });
  }

  ListView widgetListChat() {
    return ListView.builder(
      itemCount: listChat.length,
      itemBuilder: (context, index) {
        return boxChat(context, listChat[index].is_customer, index);
      },
    );
  }

  Padding boxChat(BuildContext context, positionBox, index) {
    var colorBoxChat = Color.fromRGBO(223, 239, 241, 0.5);
    var timeBoxChat;
    if (positionBox == true) {
      positionBox = Alignment.centerRight;
      colorBoxChat = Color.fromRGBO(223, 239, 241, 0.5);
      timeBoxChat = Padding(
        padding: const EdgeInsets.only(top: 15, right: 20.0, left: 20.0),
        child: Align(
          alignment: positionBox,
          child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '05.05',
                  textAlign: TextAlign.right,
                ),
                Icon(Icons.person)
              ]),
        ),
      );
    } else if (positionBox == false) {
      positionBox = Alignment.centerLeft;
      colorBoxChat = Color.fromRGBO(240, 240, 240, 0.5);
      timeBoxChat = Padding(
        padding: const EdgeInsets.only(top: 15, right: 20.0, left: 20.0),
        child: Align(
          alignment: positionBox,
          child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.person,
                  color: Color.fromRGBO(0, 154, 173, 1),
                ),
                Text(
                  '${listChat[index].nama} ',
                  style: TextStyle(
                    color: Color.fromRGBO(0, 154, 173, 1),
                  ),
                ),
                Text(
                  '05.05',
                  textAlign: TextAlign.right,
                ),
              ]),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: positionBox,
        child: Container(
            width: MediaQuery.of(context).size.width / 1.5,
            decoration: BoxDecoration(
                color: colorBoxChat,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                )),
            child: Column(
              children: [
                timeBoxChat,
                Padding(
                  padding: const EdgeInsets.only(
                    right: 20.0,
                    left: 20.0,
                    bottom: 20.0,
                  ),
                  child: Text(
                    '${listChat[index].answer}',
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
