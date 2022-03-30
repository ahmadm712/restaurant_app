import 'package:flutter/material.dart';
import 'package:restos/common/style.dart';
import 'package:restos/data/models/restaurant_api_model.dart';

class ListDrinks extends StatelessWidget {
  const ListDrinks({
    Key? key,
    required this.drinks,
  }) : super(key: key);

  final List<Category> drinks;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: thridColor.withOpacity(0.85),
        borderRadius: BorderRadius.circular(8),
      ),
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 8, bottom: 16),
      child: ListView.separated(
        itemCount: drinks.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final drink = drinks[index];
          return ListTile(
            leading: Text(
              drink.name,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: primaryColor),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }
}
