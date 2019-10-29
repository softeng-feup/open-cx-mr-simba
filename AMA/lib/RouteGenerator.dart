import 'package:ama/model/DayScheduleInfo.dart';
import 'package:ama/view/screens/AboutScreen.dart';
import 'package:ama/view/screens/BluetoothSearchScreen.dart';
import 'package:ama/view/screens/DayScheduleScreen.dart';
import 'package:ama/view/screens/DaySessionsScreen.dart';
import 'package:ama/view/screens/DaysScreen.dart';
import 'package:ama/view/screens/SessionScreen.dart';
import 'package:flutter/material.dart';
import './constants/AppColors.dart' as AppColors;
import 'controller/Controller.dart';
import 'model/Session.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {

    final args = settings.arguments;

    switch(settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => DaysScreen());


      case '/about':
        return MaterialPageRoute(builder: (_) => AboutScreen());


      case '/day1Screen':
        return MaterialPageRoute(builder: (_) => DayScheduleScreen(schedule: Controller.instance().getDaySchedule(1)));


      case '/day2Screen':
        return MaterialPageRoute(builder: (_) => DayScheduleScreen(schedule: Controller.instance().getDaySchedule(2)));


      case '/day3Screen':
        return MaterialPageRoute(builder: (_) => DayScheduleScreen(schedule: Controller.instance().getDaySchedule(3)));


      case '/day4Screen':
        return MaterialPageRoute(builder: (_) => DayScheduleScreen(schedule: Controller.instance().getDaySchedule(4)));


      case '/daySessionsScreen':
        if(args is DayScheduleInfo) {
          return MaterialPageRoute(builder: (_) => DaySessionsScreen(sessionsInfo: args));
        }
        return _errorRoute();


      case '/sessionScreen':
        if(args is Session) {
          return MaterialPageRoute(builder: (_) => SessionScreen(session: args));
        }
        return _errorRoute();


      case '/bluetoothScreen':
        return MaterialPageRoute(builder: (_) => BluetoothSearchScreen());


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