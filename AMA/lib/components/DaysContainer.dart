import 'package:flutter/material.dart';

class DaysContainer extends StatelessWidget {
  DaysContainer({this.day, this.date});

  final int day;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(day.toString()),
      ),
      body: Text(date)
    );
  }
}