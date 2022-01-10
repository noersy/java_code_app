import 'package:flutter/material.dart';
import 'package:java_code_app/constans/languages.dart';
import 'package:java_code_app/models/lang.dart';

class LangProviders extends ChangeNotifier {
  static final List<Lang> languages = [
    Lang(bottomNav: ConstLang.ind),
    Lang(bottomNav: ConstLang.eng)
  ];
  static int _indexLang = 0;

  Lang get lang => languages[_indexLang];
  bool get isIndo => _indexLang == 0;

  changeLang(bool isIndo) async {
    if(isIndo) _indexLang = 0;
    if(!isIndo) _indexLang = 1;
    notifyListeners();
  }
}
