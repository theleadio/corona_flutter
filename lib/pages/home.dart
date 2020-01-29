import 'package:corona_flutter/core/news.dart';
import 'package:corona_flutter/pages/news_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<NewsService>(
          builder: (context, newsService, _) {
            return NewsPage(
              newsService: newsService,
            );
          },
        ),
      ),
    );
  }
}
