import 'package:flutter/material.dart';
import '../components/DaysContainer.dart';
import '../constants/Dates.dart' as Dates;

class PageViewScreen extends StatefulWidget {
  _PageViewScreenState createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
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
      Padding(padding: EdgeInsets.all(40), child: DaysContainer(day: 1, date: Dates.date1)),
      Padding(padding: EdgeInsets.all(40), child: DaysContainer(day: 2, date: Dates.date2)),
      Padding(padding: EdgeInsets.all(40), child: DaysContainer(day: 3, date: Dates.date3)),
      Padding(padding: EdgeInsets.all(40), child: DaysContainer(day: 4, date: Dates.date4)),
    ],
    controller: _pageController
    );
  }
}