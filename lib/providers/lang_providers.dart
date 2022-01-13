import 'package:flutter/material.dart';
import 'package:java_code_app/constans/key_prefens.dart';
import 'package:java_code_app/constans/languages.dart';
import 'package:java_code_app/models/lang.dart';
import 'package:java_code_app/tools/shared_preferences.dart';

class LangProviders extends ChangeNotifier {
  static final Preferences _preferences = Preferences.getInstance();

  static final List<Lang> languages = [
    ConstLang.ind,
    ConstLang.eng,
  ];
  static int _indexLang = 0;

  Lang get lang => languages[_indexLang];
  bool get isIndo => _indexLang == 0;

  changeLang(bool isIndo) async {
    if(isIndo) {
      _indexLang = 0;
      _preferences.setBoolValue(KeyPrefens.lang, false);
    }

    if(!isIndo) {
      _indexLang = 1;
      _preferences.setBoolValue(KeyPrefens.lang, true);
    }


    notifyListeners();
  }

  checkLangPref() async {
    bool isEnglish = await _preferences.getBoolValue(KeyPrefens.lang);
    if(isEnglish) _indexLang = 1;
    notifyListeners();
  }
}
