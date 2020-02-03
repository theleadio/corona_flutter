import 'package:corona_flutter/core/hospital.dart';
import 'package:corona_flutter/core/stat.dart';
import 'package:corona_flutter/pages/counter_page.dart';
import 'package:corona_flutter/pages/hospital_page.dart';
import 'package:corona_flutter/utils/helper.dart';
import 'package:corona_flutter/widgets/web_view_wrapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatisticsPage extends StatefulWidget {
  final StatsService statsService;

  const StatisticsPage({
    Key key,
    this.statsService,
  }) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  final List<EmbeddedWeb> _embededWebs = [
    EmbeddedWeb(
      title: 'Analytics',
      url: 'https://www.coronatracker.com/analytics',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: _embededWebs.length + 1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            centerTitle: true,
            title: Text(
              'Statistics',
              style: TextStyle(
                fontSize: 24.0,
                fontFamily: 'AbrilFatface',
                color: Colors.black.withOpacity(0.75),
                fontWeight: FontWeight.w700,
              ),
            ),
            bottom: TabBar(
              controller: _controller,
              isScrollable: false,
              indicatorWeight: 4.0,
              labelColor: Colors.black.withOpacity(0.75),
              labelStyle: TextStyle(
                fontSize: 18.0,
                fontFamily: 'HKGrotesk',
                fontWeight: FontWeight.w700,
              ),
              tabs: [
                Tab(text: 'Counter'),
                ..._embededWebs
                    .map(
                      (web) => Tab(
                        text: web.title,
                      ),
                    )
                    .toList(),
              ],
            ),
            actions: <Widget>[
              IconButton(
                icon: Helper.getFlagIcon(
                  countryCode: widget.statsService.countryCode ?? 'GLOBAL',
                  width: 24.0,
                  height: null,
                  color: Colors.black.withOpacity(0.75),
                ),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ],
            elevation: 2.0,
            backgroundColor: Colors.grey[50],
            pinned: true,
            forceElevated: true,
          ),
        ];
      },
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          CounterPage(
            statsService: widget.statsService,
          ),
          ..._embededWebs
              .map(
                (web) => WebViewWrapper(
                  key: Key(web.title),
                  initialUrl: web.url,
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
