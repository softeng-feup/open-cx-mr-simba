import 'package:flutter/material.dart';
import '../constants/AppColors.dart' as AppColors;

class Day1Screen extends StatefulWidget {

  @override
  Day1ScreenState createState() => Day1ScreenState();
}

class Day1ScreenState extends State<Day1Screen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: Text("Day 1 Screen"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
    );
  }
}