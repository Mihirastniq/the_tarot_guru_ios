import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:the_tarot_guru/home.dart';
import 'package:the_tarot_guru/main_screens/controller/language_controller/language_change_handler.dart';
import 'package:the_tarot_guru/main_screens/reuseable_blocks.dart';

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
    _languageChangeController = LanguageChangeController();
  }

  List<Map<String, String>> defaultLanguages = [
    {'en': 'English'},
    {'hi': 'Hindi'},
    {'gu': 'Gujarati'},
  ];

  List<Map<String, String>> allLanguages = [
    {'en': 'English'},
    {'hi': 'Hindi'},
    {'gu': 'Gujarati'},
    {'mr': 'Marathi'},
    {'fr': 'French'},
    {'de': 'German'},
    {'es': 'Spanish'},
    // Add more languages as needed
  ];

  String? selectedLanguageKey;
  bool otherLanguageSelected = false;

  Future<void> updaterecord() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_selectedLanguage.isNotEmpty) {
      widget.response['language'] = _selectedLanguage;

      try {
        String uri = "https://thetarotguru.com/tarotapi/userverifaction.php";
        widget.response['phone'] = widget.response['phone'].toString();
        widget.response['otp'] = widget.response['otp'].toString();
        var requestBody = widget.response;
        var res = await http.post(Uri.parse(uri), body: requestBody);

        var response = jsonDecode(res.body);
        if (response["status"] == 'success') {
          prefs.setBool(LOGINKEY, true);
          prefs.setString('firstName', response['firstName']);
          prefs.setString('lastName', response['lastName']);
          prefs.setString('email', response['email']);
          prefs.setInt('phone', int.parse(response['phone']));
          prefs.setInt('appPin', int.parse(response['appPin']));
          prefs.setInt('userid', int.parse(response['userid']));
          prefs.setString('lang', selectedLanguageKey!);
          prefs.setString('created_at', response['created_at']['created_at']);
          prefs.setInt('osho_zen_subscription', response['osho_zen_subscription']);
          prefs.setInt('rider_waite_subscription', response['rider_waite_subscription']);
          prefs.setInt('all_app_subscription', response['all_app_subscription']);
          prefs.setInt('free_by_admin', response['free_by_admin']);
          prefs.setInt('warning', response['warning']);
          prefs.setBool('enablePin', true);

          Locale locale = Locale(selectedLanguageKey!);
          _languageChangeController = Provider.of<LanguageChangeController>(context, listen: false);

          _navigateToAppSelect();
        } else {
          print("some issue");
        }
      } catch (e) {
        print("Error: $e");
      }
    } else {
      print("Please select a language");
    }
  }

  void _navigateToAppSelect() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AppSelect()),
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
              child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Create default language options with radio buttons and GestureDetector
                            for (var language in defaultLanguages)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedLanguageKey = language.keys.first;
                                    otherLanguageSelected = false;
                                  });
                                },
                                child: Container(
                                  color: selectedLanguageKey == language.keys.first ? Colors.white : null,
                                  child: RadioListTile<String>(
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
                                        color: selectedLanguageKey == language.keys.first ? Colors.black : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            // Other Language option
                            Container(
                              color: otherLanguageSelected ? Colors.white : null,
                              child: ListTile(
                                title: Text(
                                  'Other Language',
                                  style: TextStyle(
                                    color: otherLanguageSelected ? Colors.white : Colors.black,
                                  ),
                                ),
                                leading: Radio<String>(
                                  value: '',
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
                      FullWidthButton(text: 'Register',onPressed: () {
                        if (selectedLanguageKey != null && selectedLanguageKey!.isNotEmpty) {
                          print(selectedLanguageKey);
                          updaterecord();
                        } else {
                          print('Please select a language');
                        }
                      },
                      ),
                    ],
                  )
              ),
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
                        otherLanguageSelected = false;
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
