import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restos/common/common.dart';
import 'package:restos/common/style.dart';
import 'package:restos/providers/restaurants_provider.dart';
import 'package:restos/ui/restaurant_detail_page.dart';
import 'package:restos/ui/search_page.dart';
import 'package:restos/ui/settings.dart';
import 'package:restos/utils/notification_helper.dart';
import 'package:restos/widgets/card_restaurant.dart';

import 'bookmarks_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/home";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(RestaurantDetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  int _bottomNavIndex = 0;

  final List<Widget> _listWidget = [
    const MainPage(),
    const SearchPage(),
    BookmarksPage(),
    SettingPage()
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Search',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Platform.isIOS ? CupertinoIcons.square_favorites : Icons.favorite,
      ),
      label: 'Favorite',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];
  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor.withOpacity(0.95),
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavBarItems,
        currentIndex: _bottomNavIndex,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      physics: const ScrollPhysics(),
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(bottom: 8),
          height: 200,
          decoration: const BoxDecoration(
              color: primaryColor,
              image: DecorationImage(
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
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    Text(
                      'Find Your Likely Restaurant',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'Search for the perfect restaurant for you',
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Consumer<RestaurantsProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else if (state.state == ResultState.hasData) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: state.restaurant.restaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = state.restaurant.restaurants[index];
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
                ),
              );
            } else if (state.state == ResultState.noData) {
              return Center(
                child: Text(state.message),
              );
            } else if (state.state == ResultState.error) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(state.message),
                ),
              );
            } else {
              return const Center(
                child: Text(''),
              );
            }
          },
        ),
      ],
    );
  }
}
