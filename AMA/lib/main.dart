import 'package:ama/screens/DayScheduleScreen.dart';
import 'package:ama/screens/DaysScreen.dart';
import 'package:ama/screens/AboutScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      initialRoute: '/',
      routes: {
        '/': (context) => DaysScreen(),
        '/about': (context) => AboutScreen(),
        '/day1Screen': (context) => DayScheduleScreen(day: 1),
        '/day2Screen': (context) => DayScheduleScreen(day: 2),
        '/day3Screen': (context) => DayScheduleScreen(day: 3),
        '/day4Screen': (context) => DayScheduleScreen(day: 4),
      },
    );
  }
}
