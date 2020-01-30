import 'package:ant_icons/ant_icons.dart';
import 'package:corona_flutter/core/api.dart';
import 'package:corona_flutter/core/news.dart';
import 'package:corona_flutter/core/settings.dart';
import 'package:corona_flutter/core/stat.dart';
import 'package:corona_flutter/pages/explore_page.dart';
import 'package:corona_flutter/pages/news_page.dart';
import 'package:corona_flutter/utils/constants.dart';
import 'package:corona_flutter/utils/helper.dart';
import 'package:corona_flutter/widgets/bottom_navigation_view.dart';
import 'package:corona_flutter/widgets/radio_toggle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: Consumer<Settings>(
          builder: (context, settings, child) {
            return Drawer(
              child: ListView(
                padding: EdgeInsets.only(left: 24.0, top: 32.0, bottom: 32.0),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Text(
                      'News Feed',
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
                    choices: NewsFeedType.values
                        .map(
                          (value) => ValueToggle(
                            isSelected: value == settings.feedType,
                            title: Helper.mapNewsFeedTypeEnumToString(value),
                            key: Helper.mapNewsFeedTypeEnumToString(value),
                          ),
                        )
                        .toList(),
                    onSelected: (value) {
                      if (Helper.mapStringToNewsFeedTypeEnum(value) ==
                          settings.feedType) return;

                      settings.feedType =
                          Helper.mapStringToNewsFeedTypeEnum(value);
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
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Text(
                      'Country',
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
                    choices: AppConstants.countriesList
                        .map(
                          (country) => ValueToggle(
                            isSelected: country["code"] == settings.countryCode,
                            title: country["name"],
                            key: country["code"],
                          ),
                        )
                        .toList(),
                    isFlag: true,
                    onSelected: (value) {
                      if (value == settings.countryCode) return;

                      settings.countryCode = value;
                    },
                  ),
                ],
              ),
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
                return ExplorePage(
                  statsService: statsService,
                );
              },
            ),
            Container(
              color: Colors.amber,
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationView(
          currentIndex: _currentIndex,
          activeColor: Colors.teal,
          items: [
            BottomNavigationItem(
              icon: Icon(AntIcons.profile_outline),
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
