import 'package:corona_flutter/core/api.dart';
import 'package:flutter/widgets.dart';

class Settings with ChangeNotifier {
  NewsFeedType _feedType = NewsFeedType.latest;
  NewsFeedType get feedType => _feedType;
  set feedType(NewsFeedType value) {
    if (value == _feedType) return;

    _feedType = value;
    notifyListeners();
  }

  String _countryCode = 'GLOBAL';
  String get countryCode => _countryCode;
  set countryCode(String value) {
    if (value == _countryCode) return;

    _countryCode = value;
    notifyListeners();
  }
}
