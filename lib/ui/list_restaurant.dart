import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/common.dart';

import 'package:restaurant_app/data/models/restaurant_api_model.dart';
import 'package:restaurant_app/providers/restaurants_provider.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';

class ListRestaurantPage extends StatelessWidget {
  final List<Restaurant> listRestaurant;
  const ListRestaurantPage({Key? key, required this.listRestaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: const ScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: listRestaurant.length,
      itemBuilder: (context, index) {
        final restaurant = listRestaurant[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              RestaurantDetailPage.routeName,
              arguments: restaurant,
            );
          },
          child: CardRestaurant(restaurant: restaurant),
        );
      },
    );
    ;
  }
}
