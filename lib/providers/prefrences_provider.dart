import 'package:flutter/material.dart';
import 'package:restos/common/style.dart';
import 'package:restos/data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getTheme();
    _getDailyRestaurantsPreferences();
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  bool _isDailyRestaurantsActive = false;
  bool get isDailyRestaurantsActive => _isDailyRestaurantsActive;

  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;
  void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  void _getDailyRestaurantsPreferences() async {
    _isDailyRestaurantsActive =
        await preferencesHelper.isDailyNotifRestaurantActive;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }

  void enableDailyRestaurantsNotif(bool value) {
    preferencesHelper.setDailyRestaurants(value);
    _getDailyRestaurantsPreferences();
  }
}
