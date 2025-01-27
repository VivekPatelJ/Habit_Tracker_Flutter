// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      background: Colors.grey.shade200,
      primary: Colors.grey.shade400,
      secondary: Colors.grey.shade700,
    ),
  );

  ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      background: Colors.grey.shade900,
      primary: Colors.grey.shade700,
      secondary: Colors.grey.shade500,
    ),
  );

class ThemeProvider with ChangeNotifier{
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme(){
    if(_themeData == lightMode) {
      themeData = darkMode;
    }else{
      themeData = lightMode;
    }
  }
}