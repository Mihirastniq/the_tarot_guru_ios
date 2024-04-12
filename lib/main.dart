import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:the_tarot_guru/splash_screen.dart';
import 'package:the_tarot_guru/MainScreens/theme/theme_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_tarot_guru/MainScreens/controller/audio/audio_controller.dart';
import 'package:the_tarot_guru/home.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final audioController = await initServices();
  await initServices();
  requestStoragePermission(); // Request storage permission
  runApp(MyApp());
}

void requestStoragePermission() async {
  // Request storage permission
  await Permission.storage.request();

  // Check permission status
  PermissionStatus status = await Permission.manageExternalStorage.status;
  print('Storage permission status: $status');

  // Handle permission status
  if (status.isGranted) {
    print('Storage permission granted.');
  } else if (status.isDenied) {
    print('Storage permission denied.');
    // Optionally, display a message to the user explaining why the permission is needed
  } else if (status.isPermanentlyDenied) {
    print('Storage permission permanently denied.');
    // Optionally, prompt the user to open app settings to grant the permission manually
  }
}



Future<void> initServices() async {
  await Get.putAsync(() async {
    SharedPreferences sharedPreferences;
    try {
      sharedPreferences = await SharedPreferences.getInstance();
    } catch (e) {
      print('Error initializing SharedPreferences: $e');
    }
    return AudioController();
  });
}

class MyApp extends StatelessWidget {
  final ThemeManager themeManager = Get.put(ThemeManager());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: themeManager.loadTheme(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show loading indicator
        } else {
          return Obx(() {
            return GetMaterialApp(
              title: 'The Tarot Guru',
              theme: themeManager.getTheme(),
              home: SplashScreen(),
            );
          });
        }
      },
    );
  }
}
