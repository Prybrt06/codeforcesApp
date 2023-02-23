import 'dart:ui';

import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHandler {
  static SharedPreferences? _preferences;

  Future<void> initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  void setUserName(String userName) {
    _preferences!.setString("userName", userName);
  }


  String getUserName() {
    return _preferences!.getString("userName") ?? "";
  }

  bool isDarkTheme() {
    return _preferences?.getBool('isDarkTheme') ??
        SchedulerBinding.instance.window.platformBrightness == Brightness.dark;
  }

  Future<void> toggleDarkTheme() async {
    await _preferences?.setBool('isDarkTheme', !isDarkTheme());
    print(isDarkTheme());
  }
}
