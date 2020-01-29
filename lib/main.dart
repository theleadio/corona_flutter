import 'package:corona_flutter/core/api.dart';
import 'package:corona_flutter/core/news.dart';
import 'package:corona_flutter/pages/home.dart';
import 'package:corona_flutter/pages/news_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(CoronaTrackerApp());
}

class CoronaTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final remoteRepo = RemoteRepository();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NewsService>(
          create: (_) => NewsService(remote: remoteRepo),
        ),
      ],
      child: MaterialApp(
        title: 'Corona Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          fontFamily: 'HKGrotesk',
          primarySwatch: Colors.teal,
        ),
        routes: {
          '/': (context) {
            return Home();
          },
        },
      ),
    );
  }
}
