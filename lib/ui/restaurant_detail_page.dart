import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/common.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/api/api_services.dart';

import 'package:restaurant_app/data/models/restaurant_api_model.dart';
import 'package:restaurant_app/providers/restaurant_detail_provider.dart';
import 'package:restaurant_app/providers/restaurants_provider.dart';
import 'package:restaurant_app/widgets/list_customer_review.dart';
import 'package:restaurant_app/widgets/list_drinks.dart';
import 'package:restaurant_app/widgets/list_food.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = "/detail_page";
  final String id;
  RestaurantDetailPage({required this.id});

  static const String _smallResPic =
      'https://restaurant-api.dicoding.dev/images/small/';
  static const String _medResPic =
      'https://restaurant-api.dicoding.dev/images/medium/';
  static const String _largeResPic =
      'https://restaurant-api.dicoding.dev/images/large/';

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController reviewController = TextEditingController();

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = _globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  bool isAddReview = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    reviewController.dispose();
  }

  void clearTextField() {
    nameController.clear();
    reviewController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          RestaurantDetailProvider(apiService: ApiServices(), id: widget.id),
      child: Scaffold(
        backgroundColor: primaryColor.withOpacity(0.95),
        appBar: AppBar(
          title: const Text('Detail Restaurants'),
        ),
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.HasData) {
              var restaurant = state.result.restaurant;
              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 8),
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Hero(
                        tag: restaurant.pictureId,
                        child: Image.network(
                          RestaurantDetailPage._medResPic +
                              restaurant.pictureId,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(restaurant.city),
                        RatingBar.builder(
                          initialRating: restaurant.rating.toDouble(),
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
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                        color: thridColor.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.all(8),
                    width: double.infinity,
                    child: Text(
                      restaurant.description,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: primaryColor,
                          ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'List Menu\'s Food',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const Icon(
                          Icons.food_bank,
                        )
                      ],
                    ),
                  ),
                  ListFood(foods: restaurant.menus.foods),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'List Menu\'s Drinks',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const Icon(
                          Icons.local_drink_sharp,
                        )
                      ],
                    ),
                  ),
                  ListDrinks(
                    drinks: restaurant.menus.drinks,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Customer Reviews',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const Icon(Icons.task_alt)
                      ],
                    ),
                  ),
                  ListCustomerReview(restaurant: restaurant),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (isAddReview) {
                                    isAddReview = false;
                                  } else {
                                    isAddReview = true;
                                  }
                                });
                              },
                              child: Text('Add Reviews')),
                        ),
                        isAddReview
                            ? Form(
                                key: _globalKey,
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 16),
                                  child: Column(
                                    children: [
                                      textField(
                                          controller: nameController,
                                          hint: 'Nama',
                                          icon: Icons.person),
                                      textField(
                                          controller: reviewController,
                                          hint: 'Review',
                                          icon: Icons.table_rows_rounded),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: secondaryColor,
                                          ),
                                          onPressed: () async {
                                            final function = Provider.of<
                                                        RestaurantsProvider>(
                                                    context,
                                                    listen: false)
                                                .createCustomerReview(
                                                    restaurant.id,
                                                    nameController.text,
                                                    reviewController.text);

                                            if (validateAndSave()) {
                                              if (await function) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        backgroundColor:
                                                            Color(0xff496696),
                                                        content: Text(
                                                            'Reviews Succes di tambahkan silahkan reload halaman ini')));

                                                clearTextField();
                                                setState(() {});
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        backgroundColor:
                                                            Colors.red,
                                                        content: Text(
                                                            'Reviews Gagal di tambahkan')));
                                              }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      backgroundColor:
                                                          Color(0xFFA84F4C),
                                                      content: Text(
                                                          'Isi dengan benar')));
                                            }

                                            ;
                                          },
                                          child: const Text(
                                            'Send Reviews',
                                          )),
                                    ],
                                  ),
                                ),
                              )
                            : const Text(''),
                      ],
                    ),
                  )
                ],
              );
            } else if (state.state == ResultState.NoData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.Error) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text(''));
            }
          },
        ),
      ),
    );
  }

  Container textField(
      {required TextEditingController controller,
      required IconData icon,
      required String hint}) {
    return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextFormField(
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$hint Tidak Boleh Kosong';
            }
            return null;
          },
          onChanged: (value) {
            if (value.isNotEmpty) {
              setState(() {});
              // state.fetchSearchRestaurant(value);
            }
          },
          decoration: InputDecoration(
            icon: Icon(icon),
            hintText: hint,
            border: InputBorder.none,
          ),
        ));
  }
}
