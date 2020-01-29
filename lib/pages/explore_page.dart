import 'package:corona_flutter/core/news.dart';
import 'package:corona_flutter/core/stat.dart';
import 'package:corona_flutter/widgets/counter.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  final StatsService statsService;

  const ExplorePage({
    Key key,
    this.statsService,
  }) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  ScrollController statsController;
  ScrollController appBarController;

  @override
  void initState() {
    super.initState();

    appBarController = ScrollController();
    statsController = ScrollController()
      ..addListener(() {
        appBarController.jumpTo(statsController.offset);
      });

    widget.statsService.addListener(() {
      setState(() {});
    });

    loadStats();
  }

  @override
  void dispose() {
    statsController.dispose();
    super.dispose();
  }

  loadStats() {
    widget.statsService.getStats();
  }

  Future<void> handleRefresh() async {
    setState(() {
      loadStats();
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: appBarController,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            title: Text(
              'Statistics',
              style: TextStyle(
                fontSize: 26.0,
                fontFamily: 'AbrilFatface',
                color: Colors.black.withOpacity(0.75),
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: <Widget>[],
            elevation: 0.0,
            backgroundColor: Colors.white24,
          ),
        ];
      },
      body: RefreshIndicator(
        onRefresh: handleRefresh,
        child: ListView(
          key: PageStorageKey('statsCounter'),
          children: <Widget>[
            Counter(
              number: widget.statsService.stats?.numConfirm ?? 0,
            ),
            Counter(
              number: widget.statsService.stats?.numDead ?? 0,
            ),
            Counter(
              number: widget.statsService.stats?.numHeal ?? 0,
            ),
          ],
        ),
      ),
    );
  }
}
