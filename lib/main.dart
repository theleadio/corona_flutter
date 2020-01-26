import 'package:corona_flutter/core/api.dart';
import 'package:corona_flutter/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(CoronaTrackerApp());
}

class CoronaTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiProvider>(create: (_) => RemoteRepository()),
      ],
      child: MaterialApp(
        title: 'Corona Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'HKGrotesk',
          primarySwatch: Colors.blue,
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
