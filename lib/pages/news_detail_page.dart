import 'package:ant_icons/ant_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:corona_flutter/model/model.dart';
import 'package:corona_flutter/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class NewsDetailPage extends StatefulWidget {
  final News news;

  const NewsDetailPage({
    Key key,
    this.news,
  }) : super(key: key);

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  ScrollController _scrollController;
  bool isAppBarCollapsed = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          isAppBarCollapsed = _scrollController.offset >= 200.0;
        });
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
              elevation: 4.0,
              pinned: true,
              backgroundColor: Colors.teal,
              actions: <Widget>[
                IconButton(
                  icon: Icon(AntIcons.share_alt),
                  onPressed: () {
                    Share.share('Check this out! \n ${widget.news.url}');
                  },
                )
              ],
              expandedHeight: 256.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Visibility(
                  visible: isAppBarCollapsed ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: Text(
                      widget.news.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                background: Stack(
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: widget.news.urlToImage,
                      height: 256.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.black45, Colors.transparent],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    )
                  ],
                ),
                collapseMode: CollapseMode.parallax,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 16.0,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Text(
                      widget.news.title,
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.black.withOpacity(0.75),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        '${Helper.formatDate(widget.news.publishedAt)} / ${widget.news.author}',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      widget.news.description ?? '',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 48.0,
                      child: Center(
                        child: Container(
                          height: 1.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Text(
                      widget.news.content ?? '',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black.withOpacity(0.75),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: FlatButton(
                        color: Colors.teal,
                        onPressed: () {
                          Helper.openWebUrl(
                            context: context,
                            url: widget.news.url,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Read Full Text',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
