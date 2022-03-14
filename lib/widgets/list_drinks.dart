import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/models/restaurant.dart';

class ListDrinks extends StatelessWidget {
  const ListDrinks({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final Restaurants restaurant;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: thridColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
      ),
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 8, bottom: 16),
      child: ListView.separated(
        itemCount: restaurant.menus!.drinks!.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final Drinks drink = restaurant.menus!.drinks![index];
          return ListTile(
            leading: Text(
              drink.name!,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: primaryColor),
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
