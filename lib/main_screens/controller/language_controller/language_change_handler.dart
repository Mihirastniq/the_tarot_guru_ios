import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageChangeController extends ChangeNotifier {
    Locale? NewAppLocal;
  Locale? get appLocal => NewAppLocal;

  Future<void> changelanguage(Locale type) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    NewAppLocal = type;
    if (type == Locale('en')) {
      await sp.setString('lang', 'en');
    }
    else if (type == Locale('hi')) {
      await sp.setString('lang', 'hi');
    }
    else if (type == Locale('bn')) {
      await sp.setString('lang', 'bn');
    }
    else if (type == Locale('ta')) {
      await sp.setString('lang', 'ta');
    }
    else if (type == Locale('te')) {
      await sp.setString('lang', 'te');
    }
    else if (type == Locale('kn')) {
      await sp.setString('lang', 'kn');
    }
    else if (type == Locale('ml')) {
      await sp.setString('lang', 'ml');
    }
    else if (type == Locale('mr')) {
      await sp.setString('lang', 'mr');
    }
    else if (type == Locale('gu')) {
      await sp.setString('lang', 'gu');
    }
    else if (type == Locale('pa')) {
      await sp.setString('lang', 'pa');
    }
    else if (type == Locale('or')) {
      await sp.setString('lang', 'or');
    }
    else if (type == Locale('es')) {
      await sp.setString('lang', 'es');
    }
    else if (type == Locale('fr')) {
      await sp.setString('lang', 'fr');
    }
    else if (type == Locale('de')) {
      await sp.setString('lang', 'de');
    }
    else if (type == Locale('pt')) {
      await sp.setString('lang', 'pt');
    }
    else if (type == Locale('ru')) {
      await sp.setString('lang', 'ru');
    }
    else if (type == Locale('ja')) {
      await sp.setString('lang', 'ja');
    }
    else if (type == Locale('ko')) {
      await sp.setString('lang', 'ko');
    }
    else if (type == Locale('vi')) {
      await sp.setString('lang', 'vi');
    }
    else if (type == Locale('id')) {
      await sp.setString('lang', 'id');
    } else {
      await sp.setString('lang', 'en');
    }
    notifyListeners();

  }
}