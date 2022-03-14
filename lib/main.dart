import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';
import 'package:restaurant_app/ui/splash_screen_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: myTextTheme,
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: secondaryColor,
              onPrimary: Colors.black,
              secondary: secondaryColor,
            ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: thridColor,
            onPrimary: Colors.white,
            textStyle: Theme.of(context).textTheme.subtitle1,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
        ),
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        SplashScreen.routeName: (context) => SplashScreen(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
            restaurant:
                ModalRoute.of(context)?.settings.arguments as Restaurants)
      },
    );
  }
}
