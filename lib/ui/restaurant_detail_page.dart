import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:restos/common/common.dart';
import 'package:restos/common/style.dart';
import 'package:restos/data/api/api_services.dart';

import 'package:restos/providers/restaurant_detail_provider.dart';
import 'package:restos/providers/restaurants_provider.dart';
import 'package:restos/widgets/list_customer_review.dart';
import 'package:restos/widgets/list_drinks.dart';
import 'package:restos/widgets/list_food.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = "/detail_page";
  final String id;
  const RestaurantDetailPage({required this.id});

  static const String _medResPic =
      'https://restaurant-api.dicoding.dev/images/medium/';

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController reviewController = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool isFav = false;

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
            if (state.state == ResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else if (state.state == ResultState.hasData) {
              var restaurant = state.result.restaurant;
              return ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                    margin: const EdgeInsets.only(top: 8, bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(restaurant.city,
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      color: secondaryColor,
                                    )),
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
                          onRatingUpdate: (rating) {},
                        )
                      ],
                    ),
                  ),
                  Text(
                    'Description Restaurant',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                        color: thridColor.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    child: Text(
                      restaurant.description,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: primaryColor,
                          ),
                      textAlign: TextAlign.left,
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
                    margin: const EdgeInsets.symmetric(vertical: 16),
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
                            child: Text(
                              isAddReview ? 'Hide Form' : 'Add Reviews',
                              style: const TextStyle(
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                        isAddReview
                            ? Form(
                                key: _globalKey,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: thridColor.withOpacity(0.85),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Reviews Form',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(color: primaryColor),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      textField(
                                          controller: nameController,
                                          hint: 'Nama',
                                          icon: Icons.person),
                                      textField(
                                          controller: reviewController,
                                          hint: 'Review',
                                          icon: Icons.table_rows_rounded),
                                      Center(
                                        child: ElevatedButton(
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
                                                showSnackbar(
                                                    text:
                                                        'Reviews Succes di tambahkan silahkan reload halaman ini',
                                                    context: context,
                                                    color: thridColor);

                                                clearTextField();
                                                setState(() {});
                                              } else {
                                                showSnackbar(
                                                    text:
                                                        'Reviews Gagal di tambahkan',
                                                    context: context,
                                                    color: Colors.red);
                                              }
                                            } else {
                                              showSnackbar(
                                                  text: 'Isi dengan benar',
                                                  context: context,
                                                  color: secondaryColor);
                                            }
                                          },
                                          child: const Text(
                                            'Send Reviews',
                                            style:
                                                TextStyle(color: primaryColor),
                                          ),
                                        ),
                                      ),
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
            } else if (state.state == ResultState.noData) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                    child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                )),
              );
            } else if (state.state == ResultState.error) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                    child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                )),
              );
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
