import 'package:ama/data/Session.dart';
import 'package:flutter/material.dart';
import '../constants/AppColors.dart' as AppColors;
import '../components/ActivityContainer.dart';

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

        body: Container(
          color: AppColors.backgroundColor,
          child: ActivityContainer(
            activity: Session(
              name: "MIEIC Talks",
              time: DateTime.parse("2019-07-20 20:15:00"),
              place: "Queijos - Sala B002",
              description:
              "Just a very nice talk, with MIEIC students, bla bla bla bla bla bla bla bla",
            ),
          ),
        ),
    );
  }
}