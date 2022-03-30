import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restos/common/navigation.dart';
import 'package:restos/data/api/api_services.dart';
import 'package:restos/data/db/database_helper.dart';
import 'package:restos/data/preferences/preferences_helper.dart';
import 'package:restos/providers/database_provider.dart';
import 'package:restos/providers/prefrences_provider.dart';
import 'package:restos/providers/restaurants_provider.dart';
import 'package:restos/providers/restaurants_search_provider.dart';
import 'package:restos/providers/scheduling_provider.dart';
import 'package:restos/ui/home_page.dart';
import 'package:restos/ui/restaurant_detail_page.dart';
import 'package:restos/ui/splash_screen_page.dart';
import 'package:restos/utils/background_service.dart';
import 'package:restos/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _services = BackgroundService();

  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  _services.initializeIsolate();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<RestaurantsProvider>(
            create: (_) => RestaurantsProvider(
              apiService: ApiServices(),
            ),
          ),
          ChangeNotifierProvider<RestaurantsSearchProvider>(
            create: (_) => RestaurantsSearchProvider(
              apiService: ApiServices(),
            ),
          ),
          ChangeNotifierProvider(
            create: (_) => DatabaseProvider(
              databaseHelper: DatabaseHelper(),
            ),
          ),
          ChangeNotifierProvider(
            create: (_) => SchedulingProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => PreferencesProvider(
              preferencesHelper: PreferencesHelper(
                sharedPreferences: SharedPreferences.getInstance(),
              ),
            ),
          ),
        ],
        child: Consumer<PreferencesProvider>(
          builder: (context, provider, child) {
            return MaterialApp(
              navigatorKey: navigatorKey,
              title: 'Restaurant App',
              debugShowCheckedModeBanner: false,
              theme: provider.themeData,
              initialRoute: SplashScreen.routeName,
              routes: {
                HomePage.routeName: (context) => const HomePage(),
                SplashScreen.routeName: (context) => const SplashScreen(),
                RestaurantDetailPage.routeName: (context) =>
                    RestaurantDetailPage(
                      id: ModalRoute.of(context)?.settings.arguments as String,
                    )
              },
            );
          },
        ));
  }
}
