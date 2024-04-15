import 'package:flutter/material.dart';
import 'package:the_tarot_guru/main_screens/reuseable_blocks.dart';

class LanGuageNew extends StatefulWidget {
  const LanGuageNew({Key? key});

  @override
  State<LanGuageNew> createState() => _LanGuageNewState();
}

class _LanGuageNewState extends State<LanGuageNew> {
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

  @override
  void initState() {
    super.initState();
    // Initialize selectedLanguageKey with the first default language key
    selectedLanguageKey = defaultLanguages[0].keys.first;
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

  // Function to show language selection popup
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
