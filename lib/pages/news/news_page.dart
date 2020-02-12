import 'dart:async';

import 'package:ant_icons/ant_icons.dart';
import 'package:corona_flutter/core/news.dart';
import 'package:corona_flutter/model/model.dart';
import 'package:corona_flutter/pages/news/news_detail_page.dart';
import 'package:corona_flutter/utils/helper.dart';
import 'package:corona_flutter/widgets/items/news_snippet.dart';
import 'package:corona_flutter/widgets/search_delegate.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  final NewsService newsService;

  const NewsPage({
    Key key,
    this.newsService,
  }) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  ScrollController newsFeedController;
  ScrollController appBarController;
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();

    appBarController = ScrollController();
    newsFeedController = ScrollController()
      ..addListener(() {
        setState(() {
          _isScrolled = newsFeedController.offset != 0;
        });

        appBarController.jumpTo(newsFeedController.offset);
        if (newsFeedController.offset >=
                newsFeedController.position.maxScrollExtent &&
            !newsFeedController.position.outOfRange) {
          setState(() {
            widget.newsService.page++;
            widget.newsService.fetch();
          });
        }
      });

    widget.newsService.addListener(() {
      setState(() {});
    });

    widget.newsService.fetch();
  }

  @override
  void dispose() {
    newsFeedController.dispose();
    super.dispose();
  }

  Future<void> handleRefresh() async {
    setState(() {
      widget.newsService.refresh();
    });
    return;
  }

  onTap(int nid) {
    News selectedNews =
        widget.newsService.news.firstWhere((news) => news.nid == nid);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewsDetailPage(
          news: selectedNews,
        ),
      ),
    );
  }

  _backtoTop() => newsFeedController.jumpTo(0.0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        NestedScrollView(
          controller: appBarController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                centerTitle: true,
                title: Text(
                  'Verified News',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontFamily: 'AbrilFatface',
                    color: Colors.black.withOpacity(0.75),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                leading: IconButton(
                  icon: Icon(
                    AntIcons.search_outline,
                    color: Colors.black.withOpacity(0.75),
                  ),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: NewsSearchDelegate(),
                    );
                  },
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Helper.getFlagIcon(
                      countryCode: widget.newsService.countryCode ?? 'GLOBAL',
                      width: 24.0,
                      height: null,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                ],
                elevation: 0.0,
                backgroundColor: Colors.grey[50],
                floating: true,
              ),
            ];
          },
          body: RefreshIndicator(
            onRefresh: handleRefresh,
            child: NewsFeed(
              key: PageStorageKey('newsFeed'),
              news: widget.newsService.news,
              controller: newsFeedController,
              onTap: onTap,
              state: widget.newsService.state,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 16.0,
          ),
          child: Align(
            alignment: Alignment.bottomRight,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeOut,
              transform: Matrix4.identity()
                ..translate(
                  0.0,
                  _isScrolled ? 0.0 : 120.0,
                  0.0,
                ),
              child: FloatingActionButton(
                onPressed: _backtoTop,
                elevation: 4.0,
                child: Icon(
                  Icons.keyboard_arrow_up,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NewsFeed extends StatelessWidget {
  final List<News> news;
  final Function(int) onTap;
  final ScrollController controller;
  final NewsFeedState state;

  NewsFeed({
    Key key,
    this.news,
    this.onTap,
    this.controller,
    this.state,
  }) : super(key: key);

  bool get isLoading => state == NewsFeedState.loading;

  @override
  Widget build(BuildContext context) {
    if (news.length == 0) {
      return Center(
        child: Text('No result'),
      );
    }

    return ListView.separated(
      itemCount: isLoading ? news.length + 1 : news.length,
      physics: const AlwaysScrollableScrollPhysics(),
      controller: controller,
      separatorBuilder: (context, index) {
        if (isLoading && index == news.length) {
          return Container();
        }

        return SizedBox(
          height: 12.0,
          child: Container(color: Colors.grey[200]),
        );
      },
      itemBuilder: (context, index) {
        if (isLoading && index == news.length) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        return NewsSnippet(
          nid: news[index].nid,
          title: news[index].title,
          timestamp: news[index].publishedAt ?? '',
          url: news[index].url,
          imgUrl: news[index].urlToImage ?? '',
          onTap: onTap,
        );
      },
    );
  }
}
