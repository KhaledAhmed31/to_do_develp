import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  late SharedPreferences theme;

  Future<void> initialization() async {
    theme = await SharedPreferences.getInstance();
    if (theme.getBool('theme') == null) {
      theme.setBool('theme', false);
    }
  }

  void changeTheme(bool newTheme) {
    theme.setBool('theme', newTheme);

    notifyListeners();
  }

  bool getTheme() {
    return theme.getBool('theme') ?? false;
  }
}
