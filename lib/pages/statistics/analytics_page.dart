import 'package:ant_icons/ant_icons.dart';
import 'package:corona_flutter/utils/helper.dart';
import 'package:flutter/material.dart';

class AnalyticsPage extends StatelessWidget {
  final String url;

  const AnalyticsPage({
    Key key,
    this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 24.0, top: 16.0),
            child: Text(
              'Advanced Analytics',
              style: TextStyle(
                fontSize: 45.0,
                fontFamily: 'AbrilFatface',
                fontWeight: FontWeight.w700,
                color: Colors.black.withOpacity(0.75),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Text(
              'We aggregated data from multiple sources to keep you informed on 2019 n-CoV in near real time.',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black.withOpacity(0.75),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            child: FlatButton(
              color: Colors.teal,
              onPressed: () {
                Helper.openWebUrl(
                  context: context,
                  url: url,
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Icon(
                        AntIcons.bar_chart,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'View Real Time Analytics',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
