import 'package:flutter/material.dart';
import 'package:the_tarot_guru/MainScreens/reuseable_blocks.dart';
import 'package:get/get.dart';
import '../theme/theme_settings.dart';
import 'package:the_tarot_guru/MainScreens/controller/session_controller.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  final LoginController loginController = Get.put(LoginController()) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0, // Remove shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {

          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).primaryColor,
                  Colors.black,
                ],
              ),
            ),
          ),
          // Image overlay
          Positioned.fill(
            child: Image.asset(
              'assets/images/pngbackround.png',
              fit: BoxFit.cover,
            ),
          ),
          // Centered button
          Center(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(
                        Icons.add_circle,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                      label: Text(
                        "Language",
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 3, 133, 194),
                        fixedSize: const Size(208, 43),
                      ),
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(
                        Icons.add_circle,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                      label: Text(
                        "Theme",
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 3, 133, 194),
                        fixedSize: const Size(208, 43),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _changeTheme(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text('Theme ${index + 1}'),
              onTap: () {
                int selectedThemeIndex = index;
                ThemeManager themeManager = Get.find<ThemeManager>();
                themeManager.updateTheme(selectedThemeIndex);
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}
