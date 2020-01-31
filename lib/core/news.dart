import 'package:corona_flutter/core/api.dart';
import 'package:corona_flutter/core/settings.dart';
import 'package:corona_flutter/model/model.dart';
import 'package:flutter/widgets.dart';

/// [NewsFeedState] defines the state of [NewsService].
/// * [NewsFeedState.idle] used when [NewsService] is idle and not attempting any API call from remote.
/// * [NewsFeedState.loading] used when [NewsService] is retrieving results from remote, thus Views
/// can present visual feedback during the loading state.
enum NewsFeedState { idle, loading }

/// [NewsService] serves as a Presenter in MVP context in [NewsPage].
/// [NewsService] depends on [Settings] that defines user preferences, namely [NewsFeedType]
/// and [countryCode].
class NewsService with ChangeNotifier {
  /// [ApiProvider] defines the remote repository of the app content.
  final ApiProvider remote;

  /// [Settings] controls the app content based on user preferences.
  final Settings settings;

  NewsService({
    @required this.remote,
    @required this.settings,
  }) {
    assert(remote != null);
    assert(settings != null);

    settings.addListener(refresh);
  }

  /// [page] keeps track of news offset for news feed pagination.
  int page = 0;

  List<News> _newsList = [];
  List<News> get news => _newsList;
  set news(List<News> value) {
    _newsList = value;
    state = NewsFeedState.idle;
    notifyListeners();
  }

  List<News> _searchResults = [];
  List<News> get searchResults => _searchResults;
  set searchResults(List<News> value) {
    _searchResults = value;
    state = NewsFeedState.idle;
    notifyListeners();
  }

  NewsFeedType get feedType => settings.feedType;

  String get countryCode => settings.countryCode;

  NewsFeedState state = NewsFeedState.idle;

  /// Fetch news based on current state.
  fetch() async {
    state = NewsFeedState.loading;

    List<News> newsData = await remote.fetchNews(
      offset: page * 10,
      feedType: settings.feedType ?? NewsFeedType.trending,
      countryCode: settings.countryCode ?? 'GLOBAL',
      language: settings.language ?? 'en',
    );
    news += newsData;
  }

  /// Clear all cached news feed and pagination,
  /// then retrieve a new copy of news feed.
  /// Typically use when user preferences change or when user
  /// forces content refresh.
  refresh() {
    page = 0;
    news.clear();
    fetch();
  }

  /// Search news based on user query.
  search({
    int offset = 0,
    String query = '',
  }) async {
    state = NewsFeedState.loading;
    List<News> newsData = await remote.searchNews(
      offset: offset,
      query: query,
    );
    searchResults += newsData;
  }

  /// Clear all cached search results.
  clearSearchResults() {
    searchResults.clear();
  }

  @override
  void dispose() {
    settings.removeListener(refresh);
    super.dispose();
  }
}
