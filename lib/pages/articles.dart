import 'package:corona_flutter/core/api.dart';
import 'package:corona_flutter/model/model.dart';
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
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    snapshot.data[index].title,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black.withOpacity(0.75),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}
