import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager extends GetxController {
  RxInt _themeIndex = 0.obs;

  int get currentThemeIndex => _themeIndex.value;

  ThemeData getTheme() {
    switch (_themeIndex.value) {
      case 0:
        return ThemeData(
          primaryColor: Color(0xFF191970), // Midnight Blue
          scaffoldBackgroundColor: Color(0xFF000000),
          backgroundColor: Color(0xFF000080), // Navy Blue
          cardColor: Color(0xFF000080), // Navy Blue
          buttonTheme: ButtonThemeData(
            buttonColor: Color(0xFF000080),
          ),
          iconTheme: IconThemeData(
            color: Color(0xFF000000),
          ),
          dividerColor: Color(0xFF7F6700), // Red
          highlightColor: Color(0xFF006EB5), // Gold
          hoverColor: Color(0xFF000080), // Navy Blue
          indicatorColor: Color(0xFFFFD700), // Gold
          disabledColor: Color(0xFF808080), // Gray
          canvasColor: Color(0xFF000000), // Black
          focusColor: Color(0xFF7FFFD4), // Aquamarine
          splashColor: Color(0xFF191970), // Midnight Blue
          unselectedWidgetColor: Color(0xFFFFFFFF), // White
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: Color(0xFFFFFFFF)), // White
            hintStyle: TextStyle(color: Color(0xFF7FFFD4)), // Aquamarine
          ),
        );
      case 1:
        return ThemeData(
          primaryColor: Color(0xFF710020), // Emerald Green
          scaffoldBackgroundColor: Color(0xFF510002), // Black
          backgroundColor: Color(0xFF000080), // Navy Blue
          cardColor: Color(0xFF000080), // Navy Blue
          buttonTheme: ButtonThemeData(
            buttonColor: Color(0xFF7F6700),
          ),
          dividerColor: Color(0xFF7F6700), // Red
          highlightColor: Color(0xFFFFD700), // Gold
          hoverColor: Color(0xFF7F6700), // Navy Blue
          indicatorColor: Color(0xFFFFD700), // Gold
          disabledColor: Color(0xFF808080), // Gray
          canvasColor: Color(0xFF000000), // Black
          focusColor: Color(0xFF7FFFD4), // Aquamarine
          splashColor: Color(0xFF191970), // Midnight Blue
          unselectedWidgetColor: Color(0xFFFFFFFF), // White
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: Color(0xFFFFFFFF)), // White
            hintStyle: TextStyle(color: Color(0xFF7FFFD4)), // Aquamarine
          ),
        );
      case 2:
        return ThemeData(
          primaryColor: Color(0xFFff94c1), // #ff94c1
          scaffoldBackgroundColor: Color(0xFFbe6079), // #be6079
          backgroundColor: Color(0xFF812d36), // #812d36
          cardColor: Color(0xFF752329), // #752329
          buttonTheme: ButtonThemeData(
            buttonColor: Color(0xFF69191c), // #69191c
          ),
          iconTheme: IconThemeData(
            color: Color(0xFF5e0d0f), // #5e0d0f
          ),
          dividerColor: Color(0xFF520001), // #520001
          errorColor: Color(0xFF8d3743), // #8d3743
          highlightColor: Color(0xFFc34918), // #c34918
          hoverColor: Color(0xFFba4416), // #ba4416
          indicatorColor: Color(0xFFb23f14), // #b23f14
          disabledColor: Color(0xFF812008), // #812008
          canvasColor: Color(0xFF892509), // #892509
          focusColor: Color(0xFF610a02), // #610a02
          splashColor: Color(0xFF5a0402), // #5a0402
          unselectedWidgetColor: Color(0xFF992f0d), // #992f0d
          textTheme: TextTheme(
            bodyLarge: TextStyle(color: Colors.black),
            bodyMedium: TextStyle(color: Colors.white),
            displayLarge: TextStyle(color: Color(0xFF912a0b)), // #912a0b
          ),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.black),
            hintStyle: TextStyle(color: Colors.black),
          ),
        );
      case 3:
        return ThemeData(
          primaryColor: Color(0xFFFF4500), // Deep Orange
          scaffoldBackgroundColor: Color(0xFF000000), // Black
          backgroundColor: Color(0xFF000080), // Navy Blue
          cardColor: Color(0xFF000080), // Navy Blue
          buttonTheme: ButtonThemeData(
            buttonColor: Color(0xFF000080),
          ),
          dividerColor: Color(0xFF7FFFD4), // Aquamarine
          errorColor: Color(0xFFFF0000), // Red
          highlightColor: Color(0xFFFFD700), // Gold
          hoverColor: Color(0xFF000080), // Navy Blue
          indicatorColor: Color(0xFFFFD700), // Gold
          disabledColor: Color(0xFF808080), // Gray
          canvasColor: Color(0xFF000000), // Black
          focusColor: Color(0xFF7FFFD4), // Aquamarine
          splashColor: Color(0xFF191970), // Midnight Blue
          unselectedWidgetColor: Color(0xFFFFFFFF), // White
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: Color(0xFFFFFFFF)), // White
            hintStyle: TextStyle(color: Color(0xFF7FFFD4)), // Aquamarine
          ),

        );
      case 4:
        return ThemeData(
          primaryColor: Color(0xFFDC143C), // Crimson Red
          scaffoldBackgroundColor: Color(0xFF000000), // Black
          backgroundColor: Color(0xFF000080), // Navy Blue
          cardColor: Color(0xFF000080), // Navy Blue
          buttonTheme: ButtonThemeData(
            buttonColor: Color(0xFF000080),
          ),
          dividerColor: Color(0xFF7FFFD4), // Aquamarine
          errorColor: Color(0xFFFF0000), // Red
          highlightColor: Color(0xFFFFD700), // Gold
          hoverColor: Color(0xFF000080), // Navy Blue
          indicatorColor: Color(0xFFFFD700), // Gold
          disabledColor: Color(0xFF808080), // Gray
          canvasColor: Color(0xFF000000), // Black
          focusColor: Color(0xFF7FFFD4), // Aquamarine
          splashColor: Color(0xFF191970), // Midnight Blue
          unselectedWidgetColor: Color(0xFFFFFFFF), // White
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: Color(0xFFFFFFFF)), // White
            hintStyle: TextStyle(color: Color(0xFF7FFFD4)), // Aquamarine
          ),

        );
      default:
        return ThemeData.light();
    }
  }

  Future<void> saveTheme(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeIndex', index);
    _themeIndex.value = index;
  }

  Future<int> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? themeIndex = prefs.getInt('themeIndex');
    _themeIndex.value = themeIndex ?? 0;
    return _themeIndex.value;
  }

  void updateTheme(int index) {
    _themeIndex.value = (index + 1) % 5; // 5 is the total number of themes
    saveTheme(_themeIndex.value); // Save the updated theme index
    print('Current theme index: ${_themeIndex.value}');
  }
}
