import 'package:flutter/material.dart';
import 'package:restos/common/style.dart';
import 'package:restos/data/models/restaurant_api_model.dart';

class ListFood extends StatelessWidget {
  const ListFood({Key? key, required this.foods}) : super(key: key);

  final List<Category> foods;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: thridColor.withOpacity(0.85),
        borderRadius: BorderRadius.circular(8),
      ),
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 8),
      child: ListView.separated(
        itemCount: foods.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final food = foods[index];
          return ListTile(
            leading: Text(
              food.name,
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
