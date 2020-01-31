import 'package:corona_flutter/core/api.dart';
import 'package:corona_flutter/core/settings.dart';
import 'package:corona_flutter/model/model.dart';
import 'package:flutter/widgets.dart';

/// [HospitalsService] serves as a Presenter in MVP context in [NewsPage].
/// [HospitalsService] depends on [Settings] that defines user preferences, namely [NewsFeedType]
/// and [countryCode].
class HospitalsService with ChangeNotifier {
  /// [ApiProvider] defines the remote repository of the app content.
  final ApiProvider remote;

  /// [Settings] controls the app content based on user preferences.
  final Settings settings;

  HospitalsService({
    @required this.remote,
    @required this.settings,
  }) {
    assert(remote != null);
    assert(settings != null);

    settings.addListener(refreshHospitals);
  }

  /// [localHospitalsList] is the cache for all hospitals in specific location of interest
  List<Hospital> get localHospitalsList {
    if (countryCode == 'GLOBAL') return _hospitalsList;

    if (_state == "ALL") {
      return _hospitalsList
          .where((hospital) => hospital.country == countryCode)
          .toList();
    }

    return _hospitalsList
        .where((hospital) =>
            hospital.country == countryCode && hospital.state == _state)
        .toList();
  }

  /// [hospitalsList] is the cache for all hospitals around the world
  List<Hospital> _hospitalsList = [];
  List<Hospital> get hospitalsList => _hospitalsList;
  set hospitalsList(List<Hospital> value) {
    _hospitalsList = value;
    notifyListeners();
  }

  String get countryCode => settings.countryCode;

  /// [state] defines the country state.
  /// Not to be confused with the app state.
  String _state = "ALL";
  String get state => _state;
  set state(String value) {
    if (value == _state) return;

    _state = value;
    notifyListeners();
  }

  /// Get list of unique state name in a country of interest.
  /// "ALL" is inserted as the first item as a option to retrieve
  /// all local hospitals in the country regardless of the country state.
  List<String> getStateByCountry() {
    List<String> statesAvailable = _hospitalsList
        .where((hospital) => hospital.country == countryCode)
        .map((hospital) => hospital.state)
        .toSet()
        .toList();
    statesAvailable.sort();

    return ["ALL", ...statesAvailable];
  }

  /// Clear all cached hospitals list.
  /// Typically use when user preferences change or when user
  /// forces content refresh.
  refreshHospitals() async {
    List<Hospital> hospitals = await remote.getHospitals();
    hospitalsList = hospitals;
    state = "ALL";
  }

  @override
  void dispose() {
    settings.removeListener(refreshHospitals);
    super.dispose();
  }
}
