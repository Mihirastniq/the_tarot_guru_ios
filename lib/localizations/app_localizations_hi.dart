import 'package:flutter/material.dart';

class AppLocalizationsHi {
  static const Map<String, String> _localizedStrings = {
    'hello': 'नमस्ते',
    'oshoZen': 'ओशो जेन',
    'riderWaite': 'राइडर वेट',
    'books': 'पुस्तकें',
    // Add more Hindi strings here
  };

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }

  Map<String, String> get localizedStrings => _localizedStrings;
}
