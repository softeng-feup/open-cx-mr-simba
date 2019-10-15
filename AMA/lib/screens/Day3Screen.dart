import 'package:flutter/material.dart';
import '../constants/AppColors.dart' as AppColors;

class Day3Screen extends StatefulWidget {

  @override
  Day3ScreenState createState() => Day3ScreenState();
}

class Day3ScreenState extends State<Day3Screen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text("Day 3 Screen"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}