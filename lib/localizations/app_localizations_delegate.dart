import 'package:flutter/material.dart';
import 'package:the_tarot_guru/localizations/app_localizations_en.dart';
import 'package:the_tarot_guru/localizations/app_localizations_hi.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Map<String, String>> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'hi'].contains(locale.languageCode);
  }

  @override
  Future<Map<String, String>> load(Locale locale) async {
    if (locale.languageCode == 'hi') {
      return AppLocalizationsHi().localizedStrings;
    } else {
      return AppLocalizationsEn().localizedStrings;
    }
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
