import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/ui/list_restaurant.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
      backgroundColor: secondaryColor.withOpacity(0.95),
      body: ListView(
        children: [
          _textfield((enteredKeyword) {
            _runFilter(enteredKeyword);
          }),
          Container(
            margin: const EdgeInsets.only(top: 16),
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder<String>(
              future: DefaultAssetBundle.of(context)
                  .loadString('assets/data/local_restaurant.json'),
              builder: (context, snapshot) {
                restaurants = parseRestaurant(snapshot.data);
                return restaurantsFound.isNotEmpty
                    ? ListRestaurantPage(
                        restaurants: restaurantsFound,
                      )
                    : Container(
                        alignment: Alignment.topCenter,
                        child: const Text(
                          'No results found / fill the search box',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
              },
            ),
          )
        ],
      ),
    );
  }

  Container _textfield(void Function(String enteredKeyword) _runFilter) {
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
