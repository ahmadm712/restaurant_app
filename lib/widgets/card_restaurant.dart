import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:restos/common/common.dart';
import 'package:restos/common/style.dart';

import 'package:restos/data/models/restaurant_api_model.dart';
import 'package:restos/providers/database_provider.dart';

class CardRestaurant extends StatelessWidget {
  const CardRestaurant({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final Restaurant restaurant;

  static const String _medResPic =
      'https://restaurant-api.dicoding.dev/images/medium/';

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorites(restaurant.id),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
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
                      tag: restaurant.pictureId,
                      child: Image.network(
                        _medResPic + restaurant.pictureId,
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
                    restaurant.name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        restaurant.city,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: secondaryColor,
                            ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating: restaurant.rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 16,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 8,
                            ),
                            updateOnDrag: false,
                            onRatingUpdate: (rating) {},
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          isBookmarked
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.25),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: thridColor,
                                    ),
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    onPressed: () {
                                      provider.removeBookmark(restaurant.id);
                                      showSnackbar(
                                          text: 'Remove Favorite Succes',
                                          context: context,
                                          color: Colors.red);
                                    },
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.25),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.favorite_border,
                                      color: thridColor,
                                    ),
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    onPressed: () {
                                      provider.addFavorite(restaurant);
                                      showSnackbar(
                                        text: 'Add Favorite Succes',
                                        context: context,
                                        color: thridColor,
                                      );
                                    },
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
