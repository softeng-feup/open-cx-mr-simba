import 'package:flutter/material.dart';
import '../components/DayContainer.dart';
import '../constants/Dates.dart' as Dates;

class MainScreenPager extends StatefulWidget {
  _MainScreenPagerState createState() => _MainScreenPagerState();
}

class _MainScreenPagerState extends State<MainScreenPager> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(children: <Widget>[
      Padding(padding: EdgeInsets.all(40), child: MainScreenPage(dayNo: 1, date: Dates.date1)),
      Padding(padding: EdgeInsets.all(40), child: MainScreenPage(dayNo: 2, date: Dates.date2)),
      Padding(padding: EdgeInsets.all(40), child: MainScreenPage(dayNo: 3, date: Dates.date3)),
      Padding(padding: EdgeInsets.all(40), child: MainScreenPage(dayNo: 4, date: Dates.date4)),
    ],
    controller: _pageController
    );
  }
}