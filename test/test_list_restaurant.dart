import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restos/data/api/api_services.dart';
import 'package:restos/providers/restaurants_provider.dart';
import 'package:restos/ui/home_page.dart';

void main() {
  group(
    'Testing Home Screen',
    () {
      testWidgets(
        'Testing if Restaurants ListView & ListView Main shows up',
        (WidgetTester tester) async {
          await tester.pumpWidget(createHomeScreen());
          expect(find.byType(ListView), findsWidgets);
        },
      );
    },
  );
}

Widget createHomeScreen() => ChangeNotifierProvider<RestaurantsProvider>(
      create: (_) => RestaurantsProvider(
        apiService: ApiServices(),
      ),
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
