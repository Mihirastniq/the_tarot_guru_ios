import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_tarot_guru/main_screens/controller/session_controller.dart';
import 'package:the_tarot_guru/main_screens/other_screens/language_selection.dart';
import 'package:the_tarot_guru/main_screens/reuseable_blocks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingScreenClass extends StatefulWidget {
  const SettingScreenClass({super.key});

  @override
  State<SettingScreenClass> createState() => _SettingScreenClassState();
}

class _SettingScreenClassState extends State<SettingScreenClass> {

  final LoginController loginController = LoginController();
  bool pinEnabled = false;

  @override
  void initState() {
    super.initState();
    // Fetch enablePin value from SharedPreferences when the widget initializes
    fetchEnablePin();
  }
  Future<void> fetchEnablePin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      pinEnabled = prefs.getBool('enablePin') ?? false;
    });
  }

  // Update enablePin value in SharedPreferences
  Future<void> updateEnablePin(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('enablePin', value);
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
                    Color(0xFF1C1C2D),
                    Color(0xFF1C1C2D),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: Image.asset(
                'assets/images/Screen_Backgrounds/product.png', // Replace with your image path
                fit: BoxFit.cover,
                opacity: const AlwaysStoppedAnimation(.3),
              ),
            ),
            Positioned(
              top: 5,
              left: 0,
              right: 0,
              child: AppBar(
                leading: Builder(
                  builder: (context) => IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: Icon(
                        Icons.segment_rounded,
                        color: Colors.white,
                        size: 35,
                      )),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(
                  '${AppLocalizations.of(context)!.settinglabel}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25,right: 25,top: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      ProfileButton(
                          text: '${AppLocalizations.of(context)!.languageslabel}',
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LanguageSelectionScreen()),
                            );
                          },
                          icon: Icons.language),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        child: Container(
                          // padding: EdgeInsets.only(10),
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: 2,
                                color: Colors.grey,
                              )
                          ),
                          child: ListTile(
                            leading: Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                            title: Text(
                              'Enable PIN',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            trailing: Switch(
                              value: pinEnabled,
                              onChanged: (value) {
                                setState(() {
                                  pinEnabled = value;
                                });
                                updateEnablePin(value);
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      ProfileButton(
                          text: '${AppLocalizations.of(context)!.logoutlabel}',
                          onPressed: (){
                            loginController.logout(context);
                          },
                          icon: Icons.language),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

