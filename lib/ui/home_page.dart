import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/ui/list_restaurant.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/home";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  List restaurantsFound = [];
  List restaurants = [];

  @override
  Widget build(BuildContext context) {
    void _runFilter(String enteredKeyword) {
      List results = [];
      if (enteredKeyword.isEmpty) {
        /// if the search field is empty or only contains white-space, we'll display all users
        results = restaurants;
      } else {
        results = restaurants
            .where((restaurant) => restaurant.name
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()))
            .toList();

        /// we use the toLowerCase() method to make it case-insensitive
      }

      /// Refresh the UI
      setState(() {
        restaurantsFound = results;
      });
    }

    return Scaffold(
      backgroundColor: primaryColor.withOpacity(0.95),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/data/local_restaurant.json'),
        builder: (context, snapshot) {
          restaurants = parseRestaurant(snapshot.data);

          return ListView(
            scrollDirection: Axis.vertical,
            physics: const ScrollPhysics(),
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(bottom: 8),
                height: 200,
                decoration: BoxDecoration(
                    color: primaryColor,
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/background.jpg',
                      ),
                    )),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: Column(
                        children: [
                          Text(
                            'Find Your Likely Restaurant',
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          Text(
                            'Search for the perfect restaurant for you',
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    _textfield(_runFilter),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                child: restaurantsFound.isNotEmpty
                    ? ListRestaurantPage(
                        restaurants: restaurantsFound,
                      )
                    : Container(
                        alignment: Alignment.topCenter,
                        child: const Text(
                          'No results found',
                        ),
                      ),
              )
            ],
          );
        },
      ),
    );
  }

  Container _textfield(void Function(String enteredKeyword) _runFilter) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          controller: searchController,
          onChanged: (value) {
            setState(() {
              _runFilter(value);
            });
          },
          onSubmitted: (value) {
            setState(() {
              _runFilter(value);
            });
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
  }
}
