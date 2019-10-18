import 'package:ama/data/Session.dart';
import 'package:flutter/material.dart';
import '../constants/AppColors.dart' as AppColors;

class ActivityContainer extends StatelessWidget {
  ActivityContainer({this.activity});

  final Session activity;

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