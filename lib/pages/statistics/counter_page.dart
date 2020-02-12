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
                fontSize: 45.0,
                fontFamily: 'AbrilFatface',
                fontWeight: FontWeight.w700,
                color: Colors.black.withOpacity(0.75),
              ),
            ),
          ),
          CounterWrapper(
            title: 'Total Confirmed',
            color: Color(0xFFB03060),
            number: widget.statsService.stats?.numConfirm ?? 0,
          ),
          CounterWrapper(
            title: 'Total Recovered',
            color: Color(0xFF5DBD4A),
            number: widget.statsService.stats?.numHeal ?? 0,
          ),
          CounterWrapper(
            title: 'Total Deaths',
            color: Colors.grey[700],
            number: widget.statsService.stats?.numDead ?? 0,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 24.0,
              right: 24.0,
              top: 36.0,
            ),
            child: Text(
              'Source: WHO, CDC, ECDC, NHC of the PRC, JHU CSSE, DXY, QQ, and various international media',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CounterWrapper extends StatelessWidget {
  final String title;
  final Color color;
  final int number;

  const CounterWrapper({
    Key key,
    this.title,
    this.color = Colors.teal,
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
            color: color,
            number: number,
          ),
        ],
      ),
    );
  }
}
