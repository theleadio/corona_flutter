import 'package:corona_flutter/core/api.dart';
import 'package:corona_flutter/core/settings.dart';
import 'package:corona_flutter/model/model.dart';
import 'package:flutter/widgets.dart';

class StatsService with ChangeNotifier {
  final ApiProvider remote;
  final Settings settings;

  StatsService({
    this.remote,
    this.settings,
  }) {
    settings.addListener(getStats);
  }

  String get countryCode => settings.countryCode;

  StatsCounter _stats;
  StatsCounter get stats => _stats;
  set stats(StatsCounter value) {
    _stats = value;
    notifyListeners();
  }

  String _country = '';
  String get country => _country;
  set country(String value) {
    if (value == _country) return;

    _country = value;
    getStats();
  }

  getStats() async {
    print('refresh Stats ::: ${settings.countryCode ?? 'GLOBAL'}');
    StatsCounter updatedStats = await remote.getStats(
      countryCode: settings.countryCode ?? 'GLOBAL',
    );
    stats = updatedStats;
  }

  @override
  void dispose() {
    settings.removeListener(getStats);
    super.dispose();
  }
}
