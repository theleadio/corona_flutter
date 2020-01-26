import 'package:corona_flutter/pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CoronaTrackerApp());
}

class CoronaTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
