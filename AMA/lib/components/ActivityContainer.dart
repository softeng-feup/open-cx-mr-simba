import 'package:flutter/material.dart';
import '../constants/AppColors.dart' as AppColors;

class ActivityContainer extends StatelessWidget {
  ActivityContainer({this.name, this.time, this.place, this.description});

  final String name;
  final DateTime time; // use DateTime.parse(String) to initialize the time field
  final String place;
  final String description;

  @override
  Widget build(BuildContext context) {

    double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
        width: deviceWidth * 0.95,
        height: 120,
        decoration: BoxDecoration( color: AppColors.activityColor, borderRadius: BorderRadius.all(Radius.circular(18.0))),
    );
  }
}