import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restos/common/common.dart';
import 'package:restos/common/style.dart';
import 'package:restos/providers/database_provider.dart';
import 'package:restos/ui/restaurant_detail_page.dart';
import 'package:restos/widgets/card_restaurant.dart';
import 'package:restos/widgets/platform_widget.dart';

class BookmarksPage extends StatelessWidget {
  static const String favoritesTitle = 'Favorite';

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      backgroundColor: thridColor.withOpacity(0.95),
      appBar: AppBar(
        title: const Text(favoritesTitle),
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(favoritesTitle),
      ),
      child: _buildList(),
    );
  }

  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.hasData) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  RestaurantDetailPage.routeName,
                  arguments: provider.favorites[index].id,
                ),
                child: CardRestaurant(
                  restaurant: provider.favorites[index],
                ),
              );
            },
          );
        } else {
          return Center(
            child: Text(provider.message,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: primaryColor)),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
