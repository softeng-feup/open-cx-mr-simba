import 'package:ama/json/JsonController.dart';
import 'package:ama/screens/DayScheduleScreen.dart';
import 'package:ama/screens/DaysScreen.dart';
import 'package:ama/screens/AboutScreen.dart';
import 'package:flutter/material.dart';

void main() async { 
  await JsonController().parseJsonFromURL('https://2019.programming-conference.org/dataexport/810b23a0-737b-4f74-9170-75d515274859/confero.json');
  runApp(MyApp());
}

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
