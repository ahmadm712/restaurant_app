import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});
  static const darkTheme = 'DARK_THEME';

  static const dailyRestaurant = 'DAILY_RESTAURANT';

  Future<bool> get isDailyNotifRestaurantActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyRestaurant) ?? false;
  }

  void setDailyRestaurants(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyRestaurant, value);
  }

  Future<bool> get isDarkTheme async {
    final prefs = await sharedPreferences;
    return prefs.getBool(darkTheme) ?? false;
  }

  void setDarkTheme(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(darkTheme, value);
  }
}
