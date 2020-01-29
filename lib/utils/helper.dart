import 'package:corona_flutter/core/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  static void openArticle({
    String url,
    BuildContext context,
  }) async {
    try {
      await launch(
        url,
        option: CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: CustomTabsAnimation.slideIn(),
          extraCustomTabs: <String>[
            'org.mozilla.firefox',
            'com.microsoft.emmx',
          ],
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static String formatDate(String timestamp) {
    return DateFormat.yMMMEd().add_jm().format(DateTime.parse(timestamp));
  }

  static String mapNewsFeedTypeEnumToString(NewsFeedType feedType) {
    switch (feedType) {
      case NewsFeedType.trending:
        return NewsFeedType.trending.toString();
      case NewsFeedType.latest:
        return NewsFeedType.latest.toString();
      default:
        return '';
    }
  }

  static NewsFeedType mapStringToNewsFeedEnum(String value) {
    if (value == NewsFeedType.latest.toString()) {
      return NewsFeedType.latest;
    } else {
      return NewsFeedType.trending;
    }
  }

  static updateUserPref(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static getUserPref(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }
}
