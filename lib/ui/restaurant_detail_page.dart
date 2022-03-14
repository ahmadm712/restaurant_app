import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/restaurant.dart';

class RestaurantDetailPage extends StatelessWidget {
  final Restaurants restaurant;
  static const routeName = "/detail_page";
  RestaurantDetailPage({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name!),
      ),
    );
  }
}
