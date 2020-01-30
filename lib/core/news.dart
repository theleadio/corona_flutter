import 'package:corona_flutter/core/api.dart';
import 'package:corona_flutter/core/settings.dart';
import 'package:corona_flutter/model/model.dart';
import 'package:flutter/widgets.dart';

enum NewsFeedState { idle, loading }

class NewsService with ChangeNotifier {
  final ApiProvider remote;
  final Settings settings;

  NewsService({
    this.remote,
    this.settings,
  }) {
    settings.addListener(refresh);
  }

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

  fetch() async {
    state = NewsFeedState.loading;

    List<News> newsData = await remote.fetchNews(
      offset: page * 10,
      feedType: settings.feedType ?? NewsFeedType.latest,
      countryCode: settings.countryCode ?? 'GLOBAL',
    );
    news += newsData;
  }

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

  clearSearchResults() {
    searchResults.clear();
  }

  refresh() {
    print('refresh News ::: ${settings.countryCode ?? 'GLOBAL'}');
    page = 0;
    news.clear();
    fetch();
  }

  @override
  void dispose() {
    settings.removeListener(refresh);
    super.dispose();
  }
}
