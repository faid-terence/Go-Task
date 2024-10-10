import 'package:flutter/material.dart';

class Themeprovider extends ChangeNotifier {
  ThemeData _themeData = ThemeData.light();

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == ThemeData.dark();

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    _themeData = isDarkMode ? ThemeData.light() : ThemeData.dark();
    notifyListeners();
  } 
}
