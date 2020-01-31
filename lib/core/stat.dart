import 'package:corona_flutter/core/api.dart';
import 'package:corona_flutter/core/settings.dart';
import 'package:corona_flutter/model/model.dart';
import 'package:flutter/widgets.dart';

/// [StatsService] serves as a Presenter in MVP context in [StatisticsPage].
/// [StatsService] depends on [Settings] that defines user preferences, namely [NewsFeedType]
/// and [countryCode].
class StatsService with ChangeNotifier {
  /// [ApiProvider] defines the remote repository of the app content.
  final ApiProvider remote;

  /// [Settings] controls the app content based on user preferences.
  final Settings settings;

  StatsService({
    @required this.remote,
    @required this.settings,
  }) {
    assert(remote != null);
    assert(settings != null);

    settings.addListener(getStats);
  }

  String get countryCode => settings.countryCode;

  StatsCounter _stats;
  StatsCounter get stats => _stats;
  set stats(StatsCounter value) {
    _stats = value;
    notifyListeners();
  }
  
  /// Fetch statistics based on current state.
  getStats() async {
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
