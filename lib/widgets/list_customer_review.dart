import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/models/restaurant_api_model.dart';

class ListCustomerReview extends StatelessWidget {
  const ListCustomerReview({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final RestaurantInfo restaurant;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
      ),
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 8, bottom: 16),
      child: ListView.separated(
        itemCount: restaurant.customerReviews.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final customerReview = restaurant.customerReviews[index];
          return ListTile(
            leading: Text(
              customerReview.name,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: primaryColor),
            ),
            subtitle: Text(
              customerReview.date,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: thridColor.withOpacity(1),
                  ),
            ),
            title: Text(
              customerReview.review,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: primaryColor,
                  ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }
}
