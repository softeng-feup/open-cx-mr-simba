import 'package:flutter/material.dart';
import '../constants/AppColors.dart' as AppColors;
import '../constants/Utility.dart' as Utility;

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: AppColors.mainColor,
      ),
      body: Text(
        Utility.daysScreenText
      )
    );
  }
}
