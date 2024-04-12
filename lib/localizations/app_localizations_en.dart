class AppLocalizationsEn {
  static const Map<String, String> _localizedStrings = {
    'hello': 'Hello',
    'oshoZen': 'Osho Zen',
    'riderWaite': 'Rider Waite',
    'books': 'Books',
    // Add more English strings here
  };

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }

  Map<String, String> get localizedStrings => _localizedStrings;
}
