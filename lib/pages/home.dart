import 'package:ant_icons/ant_icons.dart';
import 'package:corona_flutter/widgets/bottom_navigation_view.dart';
import 'package:flutter/material.dart';

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
        body: IndexedStack(
          index: _currentIndex,
          children: <Widget>[
            Container(
              color: Colors.teal,
            ),
            Container(
              color: Colors.black,
            ),
            Container(
              color: Colors.amber,
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationView(
          currentIndex: _currentIndex,
          activeColor: Colors.blue,
          items: [
            BottomNavigationItem(
              icon: Icon(AntIcons.profile_outline),
            ),
            BottomNavigationItem(
              icon: Icon(AntIcons.compass_outline),
            ),
            BottomNavigationItem(
              icon: Icon(AntIcons.medicine_box_outline),
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
