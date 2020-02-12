import 'package:corona_flutter/core/api.dart';
import 'package:corona_flutter/model/model.dart';
import 'package:flutter/widgets.dart';

/// [TravelAlertsService] serves as a Presenter in MVP context in [TravelAlertPage].
class TravelAlertsService with ChangeNotifier {
  /// [ApiProvider] defines the remote repository of the app content.
  final ApiProvider remote;

  TravelAlertsService({
    @required this.remote,
  }) {
    assert(remote != null);
  }

  /// [localTravelAlert] is the cache for travel alert in specific location of interest
  List<TravelAlert> get localTravelAlert {
    if (_countryCode == 'GLOBAL') return _travelAlertsList;
    
    return _travelAlertsList
        .where((travelAlert) => travelAlert.countryCode == _countryCode)
        .toList();
  }

  /// [travelAlertsList] is the cache for all travel alerts around the world
  List<TravelAlert> _travelAlertsList = [];
  List<TravelAlert> get travelAlertsList => _travelAlertsList;
  set travelAlertsList(List<TravelAlert> value) {
    _travelAlertsList = value;
    notifyListeners();
  }

  /// [countryCode] defines the country code for country of interest.
  String _countryCode = "GLOBAL";
  String get countryCode => _countryCode;
  set countryCode(String value) {
    if (value == _countryCode) return;
    
    _countryCode = value;
    notifyListeners();
  }

  /// Get list of unique country code in travel alerts available around the world.
  /// "GLOBAL" is inserted as the first item as a option to retrieve
  /// all tarvel alerts around the world.
  List<String> getCountriesCodesAvailable() {
    List<String> countriesCodesAvailable = _travelAlertsList
        .map((travelAlert) => travelAlert.countryCode)
        .toSet()
        .toList();
    countriesCodesAvailable.sort();

    return ["GLOBAL", ...countriesCodesAvailable];
  }

  /// Clear all cached travel alerts.
  refreshTravelLists() async {
    List<TravelAlert> travelAlerts = await remote.getTravelAlerts();
    travelAlertsList = travelAlerts;
  }
}
