import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';

class ListRestaurantPage extends StatelessWidget {
  const ListRestaurantPage({
    Key? key,
    required this.restaurants,
  }) : super(key: key);

  final List restaurants;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: const ScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        final Restaurants restaurant = restaurants[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              RestaurantDetailPage.routeName,
              arguments: restaurant,
            );
          },
          child: Hero(
            tag: restaurant.id!,
            child: CardRestaurant(restaurant: restaurant),
          ),
        );
      },
    );
  }
}
