import 'package:ama/constants/Dates.dart';
import 'package:ama/view/components/DayContainer.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import '../../constants/Dates.dart' as Dates;

class MainScreenPager extends StatefulWidget {
  _MainScreenPagerState createState() => _MainScreenPagerState();
}

class _MainScreenPagerState extends State<MainScreenPager> {
  PageController _pageController;
  double selectedPage;

  @override
  void initState() {
    super.initState();

    DateTime currentTime = new DateTime.now();

    if(date1.dateEqualTo(currentTime))
      selectedPage = 0;
    else if(date2.dateEqualTo(currentTime))
      selectedPage = 1;
    else if(date3.dateEqualTo(currentTime))
      selectedPage = 2;
    else if(date4.dateEqualTo(currentTime))
      selectedPage = 3;
    else 
      selectedPage = 0;


    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _onPageViewChange(int page) {
    setState(() {
      selectedPage = page.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      Padding(
          padding: EdgeInsets.only(top:40, right: 40, left: 40, bottom: 10),
          child: MainScreenPage(dayNo: 1, date: Dates.date1)),
      Padding(
          padding: EdgeInsets.only(top:40, right: 40, left: 40, bottom: 10),
          child: MainScreenPage(dayNo: 2, date: Dates.date2)),
      Padding(
          padding: EdgeInsets.only(top:40, right: 40, left: 40, bottom: 10),
          child: MainScreenPage(dayNo: 3, date: Dates.date3)),
      Padding(
          padding: EdgeInsets.only(top:40, right: 40, left: 40, bottom: 10),
          child: MainScreenPage(dayNo: 4, date: Dates.date4)),
    ];

    return Column(
      children: <Widget>[
        Expanded(
          child: PageView(
            key: Key("pageview"),
            controller: PageController(initialPage: selectedPage.toInt()),
            children: pages,
            onPageChanged: _onPageViewChange,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: DotsIndicator(
              dotsCount: pages.length,
              position: selectedPage,
              decorator: DotsDecorator(
                color: Colors.grey,
              )),
        )
      ],
    );
  }
}
