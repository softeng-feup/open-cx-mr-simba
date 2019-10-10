import 'package:flutter/material.dart';
import '../components/DaysContainer.dart';

import '../constants/Dates.dart' as Dates;

class DaysScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("AMA - Agenda Mobile App")),
        body: Center(
            child: GridView.count(
          scrollDirection: Axis.vertical,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 30,
          children: <Widget>[
            DaysContainer(day: 1, date: Dates.date1),
            DaysContainer(day: 2, date: Dates.date2),
            DaysContainer(day: 3, date: Dates.date3),
            DaysContainer(day: 4, date: Dates.date4),
          ],
        )));
  }
}
