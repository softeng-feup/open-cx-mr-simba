import 'package:ama/model/ListSessionsInfo.dart';
import 'package:ama/view/screens/AboutScreens.dart';
import 'package:ama/view/screens/BluetoothSearchScreen.dart';
import 'package:ama/view/screens/DayScheduleScreen.dart';
import 'package:ama/view/screens/ListSessionsScreen.dart';
import 'package:ama/view/screens/DaysScreen.dart';
import 'package:ama/view/screens/InitialLoadingScreen.dart';
import 'package:ama/view/screens/ItemsScreen.dart';
import 'package:ama/view/screens/ActivityCreator.dart';

import 'package:ama/view/screens/LocationsScreen.dart';

import 'package:ama/view/screens/ItemScreen.dart';

import 'package:ama/view/screens/PeopleScreen.dart';
import 'package:ama/view/screens/SessionScreen.dart';
import 'package:flutter/material.dart';
import './constants/AppColors.dart' as AppColors;
import 'controller/Controller.dart';
import 'model/Item.dart';
import 'model/Person.dart';
import 'model/Session.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {

    final args = settings.arguments;

    switch(settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => InitialLoadingScreen());
  
      case '/homeScreen':
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


      case '/listSessionsScreen':
        if(args is ListSessionsInfo) {
          return MaterialPageRoute(builder: (_) => ListSessionsScreen(sessionsInfo: args));
        }
        return _errorRoute();


      case '/sessionScreen':
        if(args is Session) {
          return MaterialPageRoute(builder: (_) => SessionScreen(session: args));
        }
        return _errorRoute();


      case '/bluetoothScreen':
        return MaterialPageRoute(builder: (_) => BluetoothSearchScreen());


      case '/personScreen':
        if(args is List<Person>) {
          return MaterialPageRoute(builder: (_) => PeopleScreen(people: args));
        }
        return _errorRoute();

      case '/itemsScreen':
        if(args is List<Item>) {
          return MaterialPageRoute(builder: (_) => ItemsScreen(items: args));
        }
        return _errorRoute();


      case '/itemScreen':
        if(args is Item) {
          return MaterialPageRoute(builder: (_) => ItemScreen(item: args));
        }
        return _errorRoute();

      case '/bluetoothAbout' :
        return MaterialPageRoute(builder: (_)=> SessionScanAboutScreen() );

      case '/locationsScreen' :
        if(args is List<String>) {
          return MaterialPageRoute(builder: (_) => LocationsScreen(locations: args));
        }

        return _errorRoute();

      case '/activityCreator' :
        return MaterialPageRoute(builder: (_) => ActivityCreatorScreen() );

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
