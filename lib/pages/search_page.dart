import 'package:corona_flutter/core/news.dart';
import 'package:corona_flutter/model/model.dart';
import 'package:corona_flutter/pages/news_detail_page.dart';
import 'package:corona_flutter/pages/news_page.dart';
import 'package:corona_flutter/utils/helper.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final NewsService newsService;
  final String query;

  const SearchPage({
    Key key,
    this.newsService,
    this.query,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  ScrollController searchResultController;
  int page = 0;

  @override
  void initState() {
    super.initState();

    searchResultController = ScrollController()
      ..addListener(() {
        if (searchResultController.offset >=
                searchResultController.position.maxScrollExtent &&
            !searchResultController.position.outOfRange) {
          setState(() {
            page++;
            searchArticles();
          });
        }
      });

    widget.newsService.addListener(update);

    widget.newsService.clearSearchResults();
    searchArticles();
  }

  update() {
    setState(() {});
  }

  @override
  void dispose() {
    widget.newsService.removeListener(update);
    searchResultController.dispose();
    super.dispose();
  }

  searchArticles() {
    widget.newsService.search(offset: page * 10, query: widget.query);
  }

  onTap(int nid) {
    News selectedNews =
        widget.newsService.searchResults.firstWhere((news) => news.nid == nid);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewsDetailPage(
          news: selectedNews,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NewsFeed(
      key: PageStorageKey('searchResult'),
      news: widget.newsService.searchResults,
      controller: searchResultController,
      onTap: onTap,
      state: widget.newsService.state,
    );
  }
}
