import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restos/common/common.dart';
import 'package:restos/common/style.dart';
import 'package:restos/data/models/restaurant_api_model.dart';

import 'package:restos/providers/restaurants_search_provider.dart';
import 'package:restos/ui/restaurant_detail_page.dart';
import 'package:restos/widgets/card_restaurant.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  List restaurantsFound = [];
  List<Restaurant> restaurants = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: thridColor.withOpacity(0.95),
      body: ListView(
        children: [
          _textfield(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Consumer<RestaurantsSearchProvider>(
              builder: (context, state, _) {
                if (state.state == ResultState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                } else if (state.state == ResultState.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const ScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: state.result!.restaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = state.result!.restaurants[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RestaurantDetailPage.routeName,
                            arguments: restaurant.id,
                          );
                        },
                        child: CardRestaurant(restaurant: restaurant),
                      );
                    },
                  );
                } else if (state.state == ResultState.noData) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Center(
                        child: Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: primaryColor),
                    )),
                  );
                } else if (state.state == ResultState.error) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Center(
                        child: Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: primaryColor),
                    )),
                  );
                } else {
                  return const Center(
                    child: Text(''),
                  );
                }
                // return state.result.restaurants.isNotEmpty
                //     ? ListView.builder(
                //         scrollDirection: Axis.vertical,
                //         physics: const ScrollPhysics(),
                //         padding: const EdgeInsets.symmetric(horizontal: 16),
                //         itemCount: state.result.restaurants.length,
                //         itemBuilder: (context, index) {
                //           final restaurant = state.result.restaurants[index];

                //           return GestureDetector(
                //             onTap: () {
                //               Navigator.pushNamed(
                //                 context,
                //                 RestaurantDetailPage.routeName,
                //                 arguments: restaurant.id,
                //               );
                //             },
                //             child: CardRestaurant(restaurant: restaurant),
                //           );
                //         },
                //       )
                //     : Container(
                //         alignment: Alignment.topCenter,
                //         child: const Text(
                //           'No results found / fill the search box',
                //           style: TextStyle(
                //             color: Colors.white,
                //           ),
                //         ),
                //       );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _textfield() {
    return Consumer<RestaurantsSearchProvider>(
      builder: (context, state, _) {
        return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {});
                  state.fetchSearchRestaurant(value);
                }
              },
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  setState(() {});
                  state.fetchSearchRestaurant(value);
                }
              },
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.search,
                  size: 18,
                  color: Colors.blueGrey,
                ),
                hintText: 'Cari',
              ),
            ));
      },
    );
  }
}

// void _runFilter(String enteredKeyword) {
//       List results = [];
//       if (enteredKeyword.isEmpty) {
//         /// if the search field is empty or only contains white-space, we'll display all users
//         results = restaurants;
//       } else {
//         results = restaurants
//             .where((restaurant) => restaurant.name
//                 .toLowerCase()
//                 .contains(enteredKeyword.toLowerCase()))
//             .toList();

//         /// we use the toLowerCase() method to make it case-insensitive
//       }

//       /// Refresh the UI
//       setState(() {
//         restaurantsFound = results;
//       });
//     }
