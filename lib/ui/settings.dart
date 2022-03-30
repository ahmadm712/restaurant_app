import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restos/common/style.dart';
import 'package:restos/providers/prefrences_provider.dart';
import 'package:restos/providers/scheduling_provider.dart';
import 'package:restos/widgets/custom_dialog.dart';
import 'package:restos/widgets/platform_widget.dart';

class SettingPage extends StatelessWidget {
  static const String settingsTitle = 'Settings';

  @override
  Widget build(BuildContext context) {
    Widget _buildList(BuildContext context) {
      return Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return ListView(
            children: [
              Material(
                child: ListTile(
                  title: const Text('Dark Theme'),
                  trailing: Switch.adaptive(
                    value: provider.isDarkTheme,
                    onChanged: (value) {
                      provider.enableDarkTheme(value);
                    },
                    // value: false,
                    // onChanged: (value) => customDialog(context),
                  ),
                ),
              ),
              Material(
                child: ListTile(
                  title: const Text('Recomended Restaurants Notification'),
                  trailing: Consumer<SchedulingProvider>(
                    builder: (context, scheduled, _) {
                      return Switch.adaptive(
                        activeColor: thridColor,
                        value: provider.isDailyRestaurantsActive,
                        onChanged: (value) async {
                          if (Platform.isIOS) {
                            customDialog(context);
                          } else {
                            scheduled.scheduledRestaurant(value);
                            provider.enableDailyRestaurantsNotif(value);
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    Widget _buildAndroid(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: _buildList(context),
      );
    }

    Widget _buildIos(BuildContext context) {
      return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Settings'),
        ),
        child: _buildList(context),
      );
    }

    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
