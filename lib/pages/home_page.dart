import 'package:ant_icons/ant_icons.dart';
import 'package:corona_flutter/core/news.dart';
import 'package:corona_flutter/core/settings.dart';
import 'package:corona_flutter/core/stat.dart';
import 'package:corona_flutter/pages/medical/medical_page.dart';
import 'package:corona_flutter/pages/news/news_page.dart';
import 'package:corona_flutter/pages/statistics/statistics_page.dart';
import 'package:corona_flutter/utils/constants.dart';
import 'package:corona_flutter/utils/helper.dart';
import 'package:corona_flutter/widgets/bottom_navigation_view.dart';
import 'package:corona_flutter/widgets/radio_toggle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: Consumer<Settings>(
          builder: (context, settings, _) {
            return AppDrawer(
              settings: settings,
            );
          },
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: <Widget>[
            Consumer<NewsService>(
              builder: (context, newsService, _) {
                return NewsPage(
                  newsService: newsService,
                );
              },
            ),
            Consumer<StatsService>(
              builder: (context, statsService, _) {
                return StatisticsPage(
                  statsService: statsService,
                );
              },
            ),
            MedicalPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationView(
          currentIndex: _currentIndex,
          activeColor: Colors.teal,
          items: [
            BottomNavigationItem(
              icon: Icon(AntIcons.home_outline),
            ),
            BottomNavigationItem(
              icon: Icon(AntIcons.line_chart),
            ),
            BottomNavigationItem(
              icon: Icon(AntIcons.medicine_box_outline),
            ),
          ],
          onTap: (index) {
            if (index == _currentIndex) return;

            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  final Settings settings;

  const AppDrawer({
    Key key,
    this.settings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.only(left: 24.0, top: 32.0, bottom: 32.0),
        children: <Widget>[
          RadioToggleSection(
            title: 'News Language',
            valueToggles: AppConstants.languagesList
                .map(
                  (lang) => ValueToggle(
                    isSelected: lang["id"] == settings.language,
                    title: lang["name"],
                    key: lang["id"],
                  ),
                )
                .toList(),
            onSelected: (value) {
              if (value == settings.language) return;

              settings.language = value;
            },
          ),
          SizedBox(
            height: 36.0,
            child: Center(
              child: Container(
                height: 1.0,
                color: Colors.grey,
              ),
            ),
          ),
          RadioToggleSection(
            title: 'Country',
            valueToggles: AppConstants.countriesList
                .map(
                  (country) => ValueToggle(
                    isSelected: country["code"] == settings.countryCode,
                    title: country["name"],
                    key: country["code"],
                  ),
                )
                .toList(),
            onSelected: (value) {
              if (value == settings.countryCode) return;

              settings.countryCode = value;
            },
            isFlag: true,
          ),
          SizedBox(
            height: 36.0,
            child: Center(
              child: Container(
                height: 1.0,
                color: Colors.grey,
              ),
            ),
          ),
          InkWell(
            highlightColor: Colors.transparent,
            radius: 120.0,
            onTap: () {
              Navigator.of(context).pop();
              Helper.openWebUrl(
                context: context,
                url: AppConstants.coronaTrackerWebUrl,
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                top: 8.0,
                bottom: 8.0,
              ),
              child: Text(
                'Website',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.75),
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          InkWell(
            highlightColor: Colors.transparent,
            radius: 120.0,
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/about');
            },
            child: Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                top: 8.0,
                bottom: 8.0,
              ),
              child: Text(
                'About',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.75),
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RadioToggleSection extends StatelessWidget {
  final String title;
  final List<ValueToggle> valueToggles;
  final void Function(dynamic) onSelected;
  final bool isFlag;

  const RadioToggleSection({
    Key key,
    this.title,
    this.valueToggles,
    this.onSelected,
    this.isFlag = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
              color: Colors.teal,
            ),
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        RadioToggle(
          choices: valueToggles,
          onSelected: onSelected,
          isFlag: isFlag,
        ),
      ],
    );
  }
}
