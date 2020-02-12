import 'package:ant_icons/ant_icons.dart';
import 'package:corona_flutter/core/api.dart';
import 'package:corona_flutter/utils/constants.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as CustomTabs;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Helper {
  /// Open web URL.
  static void openWebUrl({
    String url,
    BuildContext context,
  }) async {
    try {
      await CustomTabs.launch(
        url,
        option: CustomTabs.CustomTabsOption(
          toolbarColor: Colors.teal,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          enableInstantApps: true,
          extraCustomTabs: <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Open Geolocation.
  static void openGeolocation({
    String lat,
    String long,
    String name,
    String address,
    BuildContext context,
  }) async {
    try {
      if (await canLaunch(
          'geo:$lat,$long?q=${name.replaceAll(RegExp(' +'), '+')},+${address.replaceAll(RegExp(' +'), '+')}')) {
        await launch(
          'geo:$lat,$long?q=${name.replaceAll(RegExp(' +'), '+')},+${address.replaceAll(RegExp(' +'), '+')}',
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Open telephone number.
  static void openTelNum(String telNum) async {
    try {
      if (await canLaunch('tel:$telNum')) {
        await launch(
          'tel:$telNum',
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Format timestamp into readable format.
  static String formatLongDate(String timestamp) {
    return DateFormat.yMMMEd().add_jm().format(DateTime.parse(timestamp));
  }

  /// Format timestamp into readable format.
  static String formatShortDate(String timestamp) {
    return DateFormat.yMMMd().format(DateTime.parse(timestamp));
  }

  /// Map [NewsFeedType] enum into readable [String].
  static String mapNewsFeedTypeEnumToString(NewsFeedType feedType) {
    switch (feedType) {
      case NewsFeedType.trending:
        return 'Trending';
      case NewsFeedType.latest:
        return 'Latest';
      default:
        return '';
    }
  }

  /// Map [String] into [NewsFeedType] enum.
  static NewsFeedType mapStringToNewsFeedTypeEnum(String value) {
    if (value == 'Trending') {
      return NewsFeedType.trending;
    } else {
      return NewsFeedType.latest;
    }
  }

  /// Update user shared preferences based on key and value pair.
  static updateUserPref(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  /// Get user shared preferences based on key.
  static getUserPref(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  /// Get flag icon based on country code.
  /// Either width or height should be null, based on library docs.
  ///
  /// References:
  /// * <https://pub.dev/packages/flag>
  static Widget getFlagIcon({
    String countryCode,
    double width,
    double height,
    Color color = Colors.black,
  }) {
    assert(width == null || height == null);

    if (countryCode == "GLOBAL") {
      return Icon(
        AntIcons.global,
        size: width ?? height,
        color: color,
      );
    }

    // Wrong flag for MY. Workaround until Flag library got it fixed
    if (countryCode == "MY") {
      String assetName = 'assets/img/' + countryCode.toLowerCase() + '.svg';
      Widget svg = SvgPicture.asset(
        assetName,
        semanticsLabel: countryCode,
        height: height,
        width: width + 8.0,
      );
      return svg;
    }

    return Flags.getMiniFlag(countryCode, width, height);
  }

  /// Map country code into country name.
  static String getCountryName(String countryCode) {
    assert(countryCode != null);

    try {
      String countryName = AppConstants.fullCountriesList.firstWhere(
          (country) => country["code"] == countryCode.toUpperCase())["name"];

      // return empty string if country code is 'GLOBAL', for API calling purpose.
      return countryName == 'GLOBAL' ? '' : countryName;
    } catch (e) {
      return 'GLOBAL';
    }
  }
}
