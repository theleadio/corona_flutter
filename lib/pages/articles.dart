import 'package:corona_flutter/core/api.dart';
import 'package:corona_flutter/model/model.dart';
import 'package:corona_flutter/widgets/items/article_snippet.dart';
import 'package:flutter/material.dart';

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

  // todo:
  void _openArticle() {}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: articles,
      builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
        if (snapshot.hasData) {
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
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return ArticleSnippet(
                  title: snapshot.data[index].title,
                  timestamp: snapshot.data[index].publishedAt ?? '',
                  imgUrl: snapshot.data[index].urlToImage ?? '',
                  onTap: _openArticle,
                );
              },
            ),
          );
        }
        // Placeholder for error prompt
        return Container();
      },
    );
  }
}
