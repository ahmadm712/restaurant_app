import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_app/data/models/restaurant.dart';

class CardRestaurant extends StatelessWidget {
  const CardRestaurant({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final Restaurants restaurant;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Hero(
              tag: restaurant.pictureId!,
              child: Image.network(
                restaurant.pictureId!,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            restaurant.name!,
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                restaurant.city!,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(
                width: 8,
              ),
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
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
        ],
      ),
    );
  }
}
