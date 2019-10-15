import 'package:flutter/material.dart';
import '../constants/AppColors.dart' as AppColors;

class Day4Screen extends StatefulWidget {

  @override
  Day4ScreenState createState() => Day4ScreenState();
}

class Day4ScreenState extends State<Day4Screen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text("Day 4 Screen"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}