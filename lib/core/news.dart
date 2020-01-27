import 'package:corona_flutter/core/api.dart';
import 'package:corona_flutter/model/model.dart';
import 'package:flutter/widgets.dart';

enum NewsFeedState { idle, loading }

class NewsService with ChangeNotifier {
  final ApiProvider remote;

  NewsService({this.remote});

  List<News> _newsList = [];

  List<News> get news => _newsList;

  set news(List<News> updatedNews) {
    _newsList = updatedNews;
    notifyListeners();
  }

  fetch({
    int offset = 0,
    NewsFeedType feedType,
  }) async {
    List<News> newsData = await remote.fetchNews(
      offset: offset,
      feed: feedType,
    );
    news += newsData;
  }

  clear() {
    news.clear();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
