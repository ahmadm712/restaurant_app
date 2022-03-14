import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/widgets/list_drinks.dart';
import 'package:restaurant_app/widgets/list_food.dart';

class RestaurantDetailPage extends StatelessWidget {
  final Restaurants restaurant;
  static const routeName = "/detail_page";
  RestaurantDetailPage({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor.withOpacity(0.95),
      appBar: AppBar(
        title: Text(restaurant.name!),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 8),
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                restaurant.pictureId!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            restaurant.name!,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(restaurant.city!),
                RatingBar.builder(
                  initialRating: restaurant.rating!,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 16,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 8,
                  ),
                  updateOnDrag: false,
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
                color: thridColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(16)),
            padding: EdgeInsets.all(8),
            width: double.infinity,
            child: Text(
              restaurant.description!,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: primaryColor,
                  ),
              textAlign: TextAlign.justify,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'List Menu\'s Food',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Icon(
                  Icons.food_bank,
                )
              ],
            ),
          ),
          ListFood(restaurant: restaurant),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'List Menu\'s Drinks',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Icon(
                  Icons.local_drink_sharp,
                )
              ],
            ),
          ),
          ListDrinks(restaurant: restaurant),
        ],
      ),
    );
  }
}
