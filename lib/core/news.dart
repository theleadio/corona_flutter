import 'package:corona_flutter/core/api.dart';
import 'package:corona_flutter/model/model.dart';
import 'package:flutter/widgets.dart';

enum NewsFeedState { idle, loading }

class NewsService with ChangeNotifier {
  final ApiProvider remote;

  NewsService({this.remote});

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

  NewsFeedState state = NewsFeedState.idle;

  fetch({
    int offset = 0,
    NewsFeedType feedType,
  }) async {
    state = NewsFeedState.loading;
    List<News> newsData = await remote.fetchNews(
      offset: offset,
      feedType: feedType,
    );
    news += newsData;
  }

  clearNews() {
    news.clear();
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

  @override
  void dispose() {
    super.dispose();
  }
}
