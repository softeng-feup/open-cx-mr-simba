
import 'package:ama/data/DaySessionsInfo.dart';
import 'package:ama/data/Session.dart';
import 'package:ama/main.dart';
import 'package:ama/screens/AboutScreen.dart';
import 'package:ama/screens/DayScheduleScreen.dart';
import 'package:ama/screens/DaysScreen.dart';
import 'package:ama/screens/DaySessionsScreen.dart';
import 'package:ama/screens/SessionScreen.dart';
import 'package:flutter/material.dart';
import './constants/AppColors.dart' as AppColors;

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {

    final args = settings.arguments;

    switch(settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => DaysScreen());


      case '/about':
        return MaterialPageRoute(builder: (_) => AboutScreen());


      case '/day1Screen':
        return MaterialPageRoute(builder: (_) => DayScheduleScreen(info: MyApp.database.scheduleInfoDay1));


      case '/day2Screen':
        return MaterialPageRoute(builder: (_) => DayScheduleScreen(info: MyApp.database.scheduleInfoDay2));


      case '/day3Screen':
        return MaterialPageRoute(builder: (_) => DayScheduleScreen(info: MyApp.database.scheduleInfoDay3));


      case '/day4Screen':
        return MaterialPageRoute(builder: (_) => DayScheduleScreen(info: MyApp.database.scheduleInfoDay4));


      case '/daySessionsScreen':
        if(args is DaySessionsInfo) {
          return MaterialPageRoute(builder: (_) => DaySessionsScreen(sessionsInfo: args));
        }
        return _errorRoute();


      case '/sessionScreen':
        if(args is Session) {
          return MaterialPageRoute(builder: (_) => SessionScreen(session: args));
        }
        return _errorRoute();


      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: Text("ERROR", style: TextStyle(color: Colors.white)),
        ),

        body: Container(
          color: AppColors.backgroundColor,
        ),
      );
    }
    );
  }
}