import 'package:corona_flutter/core/api.dart';
import 'package:corona_flutter/utils/constants.dart';
import 'package:corona_flutter/utils/helper.dart';
import 'package:flutter/widgets.dart';

class Settings with ChangeNotifier {
  NewsFeedType _feedType;
  NewsFeedType get feedType => _feedType;
  set feedType(NewsFeedType value) {
    if (value == _feedType) return;

    _feedType = value;
    Helper.updateUserPref(AppConstants.sprefNewsFeedType,
        Helper.mapNewsFeedTypeEnumToString(_feedType));
    notifyListeners();
  }

  String _country;
  String get country => _country;
  set country(String value) {
    if (value == _country) return;

    _country = value;
    Helper.updateUserPref(AppConstants.sprefCountry, _country);
    notifyListeners();
  }

  Settings() {
    init();
  }

  init() async {
    _feedType = Helper.mapStringToNewsFeedEnum(
        await Helper.getUserPref(AppConstants.sprefNewsFeedType));
    _country = await Helper.getUserPref(AppConstants.sprefCountry);
  }
}
