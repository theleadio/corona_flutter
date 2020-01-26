import 'package:ant_icons/ant_icons.dart';
import 'package:corona_flutter/core/api.dart';
import 'package:corona_flutter/model/model.dart';
import 'package:corona_flutter/widgets/items/article_snippet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'dart:async';

class Articles extends StatefulWidget {
  final ApiProvider remote;

  const Articles({
    Key key,
    this.remote,
  }) : super(key: key);

  @override
  _ArticlesState createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  Future<List<Article>> articles;

  @override
  void initState() {
    super.initState();
    articles = widget.remote.fetchArticles();
  }

  void _openArticle(String url) async {
    try {
      await launch(
        url,
        option: CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: CustomTabsAnimation.slideIn(),
          extraCustomTabs: <String>[
            'org.mozilla.firefox',
            'com.microsoft.emmx',
          ],
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: articles,
      builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return RefreshIndicator(
            onRefresh: () {
              return widget.remote.fetchArticles();
            },
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 12.0,
                  child: Container(color: Colors.grey[200]),
                );
              },
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: snapshot.data.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Articles',
                            style: TextStyle(
                              fontSize: 28.0,
                              color: Colors.black.withOpacity(0.75),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(AntIcons.sliders_outline),
                          onPressed: () {},
                        )
                      ],
                    ),
                  );
                }

                return ArticleSnippet(
                  title: snapshot.data[index - 1].title,
                  timestamp: snapshot.data[index - 1].publishedAt ?? '',
                  url: snapshot.data[index - 1].url,
                  imgUrl: snapshot.data[index - 1].urlToImage ?? '',
                  onTap: _openArticle,
                );
              },
            ),
          );
        }
        // Placeholder for error prompt
        return CircularProgressIndicator();
      },
    );
  }
}
