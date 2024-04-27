import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:the_tarot_guru/home.dart';
import 'package:the_tarot_guru/main_screens/controller/language_controller/language_change_handler.dart';
import 'package:the_tarot_guru/main_screens/reuseable_blocks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageSelection extends StatefulWidget {
  final Map<String, dynamic> response;

  LanguageSelection({required this.response});

  @override
  _LanguageSelectionState createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection> {
  String _selectedLanguage = 'English';
  String LOGINKEY = "isLogin";
  bool? isLogin = false;
  late LanguageChangeController _languageChangeController;

  @override
  void initState() {
    super.initState();
    _languageChangeController = Provider.of<LanguageChangeController>(context, listen: false);
  }

  List<Map<String, String>> defaultLanguages = [
    {'en': 'English'},
    {'hi': 'Hindi'},
    {'gu': 'Gujarati'},
  ];

  List<Map<String, String>> allLanguages = [
    {'en': 'English'},
    {'hi': 'Hindi'},
    {'bn': 'Bengali'},
    {'ta': 'Tamil'},
    {'te': 'Telugu'},
    {'kn': 'Kannada'},
    {'ml': 'Malayalam'},
    {'mr': 'Marathi'},
    {'gu': 'Gujarati'},
    {'pa': 'Punjabi'},
    {'or': 'Odia'},
    {'es': 'Spanish'},
    {'fr': 'French'},
    {'de': 'German'},
    {'pt': 'Portuguese'},
    {'ru': 'Russian'},
    {'ja': 'Japanese'},
    {'ko': 'Korean'},
    {'vi': 'Vietnamese'},
    {'id': 'Indonesian'},
  ];

  String? selectedLanguageKey;
  bool otherLanguageSelected = false;

  Future<void> updaterecord() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_selectedLanguage.isNotEmpty) {
      Locale locale = Locale(_selectedLanguage);
      await _languageChangeController.changelanguage(locale);
      widget.response['language'] = _selectedLanguage;

      try {
        String uri = "https://thetarotguru.com/tarotapi/userverifaction.php";
        var requestBody = jsonEncode(widget.response);
        print(requestBody);
        var res = await http.post(Uri.parse(uri), body: requestBody);
        print(res.body);
        var response = jsonDecode(res.body);
        if (response["status"] == 'success') {
          prefs.setBool(LOGINKEY, true);
          prefs.setString('firstName', response['firstName']);
          prefs.setString('lastName', response['lastName']);
          prefs.setString('email', response['email']);
          // prefs.setString('phone', response['phone']); // Commented out for testing
          prefs.setInt('appPin', int.parse(response['appPin']));
          prefs.setInt('userid', int.parse(response['userid']));
          prefs.setString('lang', _selectedLanguage);
          prefs.setString('created_at', response['created_at']['created_at']);
          prefs.setInt('subscription_status', response['subscription_status']);
          prefs.setInt('free_by_admin', response['free_by_admin']);
          prefs.setInt('warning', response['warning']);
          prefs.setBool('enablePin', true);
          _navigateToAppSelect();
        } else {
          Fluttertoast.showToast(
            msg: "Try again after some time",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 15,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
        Fluttertoast.showToast(
          msg: "Verification Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 15,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } catch (e) {
        print(e);
        Fluttertoast.showToast(
          msg: "Try again after some time",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 15,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Select your Language",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 15,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void _navigateToAppSelect() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AppSelect()),
    );
  }

  Widget logo(double height_, double width_) {
    return Image.asset(
      'assets/images/intro/logo.png',
      height: height_,
      width: width_,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: SafeArea(
        child: Stack(
          children: [
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
            Positioned(
              left: -34,
              top: 181.0,
              child: SvgPicture.string(
                // Group 3178
                '<svg viewBox="-34.0 181.0 99.0 99.0" ><path transform="translate(-34.0, 181.0)" d="M 74.25 0 L 99 49.5 L 74.25 99 L 24.74999618530273 99 L 0 49.49999618530273 L 24.7500057220459 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-26.57, 206.25)" d="M 0 0 L 42.07500076293945 16.82999992370605 L 84.15000152587891 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(15.5, 223.07)" d="M 0 56.42999649047852 L 0 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                width: 99.0,
                height: 99.0,
              ),
            ),
            Positioned(
              right: -52,
              top: 45.0,
              child: SvgPicture.string(
                // Group 3177
                '<svg viewBox="288.0 45.0 139.0 139.0" ><path transform="translate(288.0, 45.0)" d="M 104.25 0 L 139 69.5 L 104.25 139 L 34.74999618530273 139 L 0 69.5 L 34.75000762939453 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(298.42, 80.45)" d="M 0 0 L 59.07500076293945 23.63000106811523 L 118.1500015258789 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(357.5, 104.07)" d="M 0 79.22999572753906 L 0 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                width: 139.0,
                height: 139.0,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Column(
                    children: [
                      logo(100, 100),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),

                  Text(
                    'Select your Language',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (var language in defaultLanguages)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedLanguageKey = language.keys.first;
                                otherLanguageSelected = false;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: selectedLanguageKey == language.keys.first ? Color(0xFF272B34) : null,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: RadioListTile<String>(
                                activeColor: Colors.white,
                                value: language.keys.first,
                                groupValue: selectedLanguageKey,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedLanguageKey = value;
                                    otherLanguageSelected = false;
                                  });
                                },
                                title: Text(
                                  language.values.first,
                                  style: TextStyle(
                                    color: selectedLanguageKey == language.keys.first ? Colors.white : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        // Other Language option
                        Container(
                          decoration: BoxDecoration(
                              color: otherLanguageSelected ? Color(0xFF272B34) : null,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: ListTile(
                            title: Text(
                              'Other Language',
                              style: TextStyle(
                                color: otherLanguageSelected ? Colors.white : Colors.white,
                              ),
                            ),
                            leading: Radio<String>(
                              value: '',
                              activeColor: otherLanguageSelected ? Color(0xFF272B34) : null,
                              groupValue: selectedLanguageKey,
                              onChanged: (String? value) {
                                setState(() {
                                  otherLanguageSelected = true;
                                  _showLanguagePopup(context);
                                });
                              },
                            ),
                            onTap: () {
                              setState(() {
                                otherLanguageSelected = true;
                              });
                              _showLanguagePopup(context);
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        // Submit button

                      ],
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xFFFFFFFF),
                      ),
                      child: Text(
                          '${AppLocalizations.of(context)!.singin}'
                      ),
                    ),
                    onTap: () {
                      if (selectedLanguageKey != null && selectedLanguageKey!.isNotEmpty) {
                        updaterecord();
                      } else {
                        print('Please select a language');
                      }
                    },
                  )
                ],
              )
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguagePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Language'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                // Create language options for all languages in a popup
                for (var language in allLanguages)
                  ListTile(
                    title: Text(language.values.first),
                    onTap: () {
                      setState(() {
                        selectedLanguageKey = language.keys.first;
                        otherLanguageSelected = true;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
