import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_tarot_guru/home.dart';
import 'package:the_tarot_guru/main_screens/Login/login_pin.dart';
import 'package:the_tarot_guru/introduction_animation/introduction_animation_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Timer(
      Duration(seconds: 2),
          () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        bool isLoggedIn = prefs.getBool("isLogin") ?? false;
        bool isPinEnabled = prefs.getBool("enablePin") ?? true;

        if (isLoggedIn) {
          if (isPinEnabled) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PinEntryScreen()));
          } else {
            // Navigate to home screen if the user is logged in and PIN is not enabled
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppSelect()));
          }
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) => IntroductionAnimationScreen()));
        }
      },
    );

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(4, 2, 12, 1.0),
                  Color.fromRGBO(4, 2, 12, 1.0),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/Screen_Backgrounds/bg1.png', // Replace with your image path
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.1),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.sizeOf(context).width*0.7,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Image.asset('assets/images/intro/logo.png'),
                    ),
                    Text(
                        "Know your past, recognize your present and create your future. Know the answer to every question of your life through Tarot cards.",
                        textAlign: TextAlign.center,
                        style: _getTitleTextStyle(context)
                    ),
                  ],
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
  TextStyle _getTitleTextStyle(BuildContext context) {
    // Define default text style
    double lineHeight = 1.8;
    TextStyle defaultStyle = GoogleFonts.anekDevanagari(
        color: Colors.white,
        fontSize: 23,
        fontWeight:
        FontWeight.w600,
        height: lineHeight
    );

    // Check the language and set appropriate font
    if (Localizations.localeOf(context).languageCode == 'hi') {
      return GoogleFonts.anekDevanagari(
          color: Colors.white,
          fontSize: 23,
          fontWeight:
          FontWeight.w600,
          height: lineHeight
      );
    } else {
      return defaultStyle;
    }
  }
}
