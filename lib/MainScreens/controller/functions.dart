import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/theme_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

void changeTheme(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? themeIndex = prefs.getInt('themeIndex');

  if (themeIndex == null) {
    // If themeIndex is null, set it to 1
    themeIndex = 1;
    await prefs.setInt('themeIndex', themeIndex);
  } else {
    // Increment the theme index by 1
    themeIndex++;
    await prefs.setInt('themeIndex', themeIndex);
  }

  // Update the theme using GetX
  ThemeManager themeManager = Get.find<ThemeManager>();
  themeManager.updateTheme(themeIndex);
}
