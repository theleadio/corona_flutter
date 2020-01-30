import 'package:corona_flutter/core/api.dart';
import 'package:corona_flutter/core/settings.dart';
import 'package:corona_flutter/model/model.dart';
import 'package:flutter/widgets.dart';

class HospitalsService with ChangeNotifier {
  final ApiProvider remote;
  final Settings settings;

  HospitalsService({
    this.remote,
    this.settings,
  }) {
    settings.addListener(refreshHospitals);
  }

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

  List<Hospital> _hospitalsList = [];
  List<Hospital> get hospitalsList => _hospitalsList;
  set hospitalsList(List<Hospital> value) {
    _hospitalsList = value;
    notifyListeners();
  }

  String get countryCode => settings.countryCode;

  String _state = "ALL";
  String get state => _state;
  set state(String value) {
    if (value == _state) return;

    _state = value;
    notifyListeners();
  }

  List<String> getStateByCountry() {
    List<String> statesAvailable = _hospitalsList
        .where((hospital) => hospital.country == countryCode)
        .map((hospital) => hospital.state)
        .toSet()
        .toList();
    statesAvailable.sort();

    return ["ALL", ...statesAvailable];
  }

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
