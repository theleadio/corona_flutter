import 'package:corona_flutter/core/stat.dart';
import 'package:corona_flutter/utils/helper.dart';
import 'package:corona_flutter/widgets/counter.dart';
import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  final StatsService statsService;

  const CounterPage({
    Key key,
    this.statsService,
  }) : super(key: key);

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    widget.statsService.addListener(() {
      setState(() {});
    });

    loadStats();
  }

  @override
  bool get wantKeepAlive => true;

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
    super.build(context);
    return RefreshIndicator(
      onRefresh: handleRefresh,
      child: ListView(
        key: PageStorageKey('statsCounter'),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 24.0, top: 16.0),
            child: Text(
              '${Helper.getCountryName(widget.statsService.countryCode ?? 'GLOBAL')}',
              style: TextStyle(
                fontSize: 50.0,
                fontFamily: 'AbrilFatface',
                fontWeight: FontWeight.w700,
                color: Colors.black.withOpacity(0.75),
              ),
            ),
          ),
          CounterWrapper(
            title: 'Number Confirmed',
            number: widget.statsService.stats?.numConfirm ?? 0,
          ),
          CounterWrapper(
            title: 'Number Dead',
            number: widget.statsService.stats?.numDead ?? 0,
          ),
          CounterWrapper(
            title: 'Number Healed',
            number: widget.statsService.stats?.numHeal ?? 0,
          ),
        ],
      ),
    );
  }
}

class CounterWrapper extends StatelessWidget {
  final String title;
  final int number;

  const CounterWrapper({
    Key key,
    this.title,
    this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 12.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              color: Colors.black.withOpacity(0.75),
            ),
          ),
          AnimatedCounter(
            number: number,
          ),
        ],
      ),
    );
  }
}
