import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutOshoZen extends StatefulWidget {
  const AboutOshoZen({Key? key}) : super(key: key);

  @override
  State<AboutOshoZen> createState() => _AboutOshoZenState();
}

class _AboutOshoZenState extends State<AboutOshoZen> {
  late String _title = '';
  late String _text = '';

  @override
  void initState() {
    super.initState();
    _loadAboutOshoData();
  }

  Future<void> _loadAboutOshoData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String selectedLanguage = prefs.getString('lang') ?? 'en';

    try {
      // Load JSON data
      String data = await DefaultAssetBundle.of(context)
          .loadString('assets/json/about_osho.json');
      Map<String, dynamic> jsonData = jsonDecode(data);

      // Fetch data based on selected language
      List<dynamic> languageData = jsonData[selectedLanguage]['data'];
      Map<String, dynamic> aboutOshoData = languageData.isNotEmpty
          ? languageData.first
          : jsonData['en']['data'].first; // Fallback to English if data is not available for the selected language

      setState(() {
        _title = aboutOshoData['title'];
        _text = aboutOshoData['text'];
      });
    } catch (e) {
      print('Error loading about osho data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(19, 14, 42, 1),
                    Theme.of(context).primaryColor.withOpacity(0.2),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: Image.asset(
                'assets/images/Screen_Backgrounds/bg3.png',
                fit: BoxFit.cover,
                opacity: const AlwaysStoppedAnimation(.3),
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(15)),
                height: MediaQuery.of(context).size.height * 0.8,
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.star, color: Colors.white, size: 20),
                            Icon(Icons.star, color: Colors.white, size: 20),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(_title ?? 'Loading...',
                            style: _getTitleTextStyle(context)),
                        SizedBox(height: 10),
                        Text(_text ?? 'Loading...',
                            style: _getCustomTextStyle(context)),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.star, color: Colors.white, size: 20),
                            Icon(Icons.star, color: Colors.white, size: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }

  TextStyle _getCustomTextStyle(BuildContext context) {
    double lineHeight = 1.8;

    TextStyle defaultStyle = GoogleFonts.anekDevanagari(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Colors.white,
        height: lineHeight);

    if (Localizations.localeOf(context).languageCode == 'hi') {
      return GoogleFonts.anekDevanagari(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Colors.white,
          height: lineHeight);
    } else {
      return defaultStyle;
    }
  }

  TextStyle _getTitleTextStyle(BuildContext context) {
    TextStyle defaultStyle = GoogleFonts.anekDevanagari(
        color: Colors.white, fontSize: 23, fontWeight: FontWeight.w600);

    if (Localizations.localeOf(context).languageCode == 'hi') {
      return GoogleFonts.anekDevanagari(
          color: Colors.white, fontSize: 23, fontWeight: FontWeight.w600);
    } else {
      return defaultStyle;
    }
  }
}
