import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/ui/list_restaurant.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/home";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List restaurants = [];
  int _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _listWidget = [
      MainPage(context),
      const SearchPage(),
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
    ];
    void _onBottomNavTapped(int index) {
      setState(() {
        _bottomNavIndex = index;
      });
    }

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

  FutureBuilder<String> MainPage(BuildContext context) {
    return FutureBuilder<String>(
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
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: ListRestaurantPage(
                restaurants: restaurants,
              ),
            )
          ],
        );
      },
    );
  }
}
