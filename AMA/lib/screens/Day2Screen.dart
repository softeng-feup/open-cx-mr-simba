import 'package:flutter/material.dart';
import '../constants/AppColors.dart' as AppColors;

class Day2Screen extends StatefulWidget {

  @override
  Day2ScreenState createState() => Day2ScreenState();
}

class Day2ScreenState extends State<Day2Screen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text("Day 2 Screen"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}