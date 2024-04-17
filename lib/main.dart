import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_tarot_guru/home.dart';
import 'package:the_tarot_guru/main_screens/controller/counter_provider.dart';
import 'package:the_tarot_guru/main_screens/theme/theme_settings.dart';
import 'package:the_tarot_guru/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'main_screens/controller/language_controller/language_change_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();
  final String language = sp.getString('lang') ?? 'en';
  print('local is : $language');
  runApp(MyApp(local: language));
}

class MyApp extends StatefulWidget {
  final String? local;
  MyApp({Key? key, required this.local});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Locale defaultLocale = Locale('en');

    Locale locale = widget.local != null && widget.local!.isNotEmpty ? Locale(widget.local!) : defaultLocale;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeManager()),
        ChangeNotifierProvider(create: (_) => LanguageChangeController()),
      ],
      child: Consumer2<LanguageChangeController, ThemeManager>(
        builder: (context, languageProvider, themeManager, child) {
          return MaterialApp(
            title: 'The Tarot Guru',
            theme: themeManager.getTheme(),
            locale: languageProvider.appLocal ?? locale,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
