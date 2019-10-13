import 'package:flutter/material.dart';
import '../components/DaysContainer.dart';
import '../constants/Dates.dart' as Dates;
import '../constants/AppColors.dart' as AppColors;
import '../constants/Utility.dart' as Utility;

class DaysScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "AMA - Agenda Mobile App",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: AppColors.mainColor,
      ),
      body: Container(
          color: AppColors.backgroundColor,
          child: Column(
            children: <Widget>[

              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
                child:  Text(Utility.daysScreenText, style: TextStyle(color: AppColors.mainColor, fontSize: 23), textAlign: TextAlign.center,),
              ),

              Expanded(
                  child: Center(
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 5.0),
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
                    )),
              ))
            ],
          )),
    );
  }
}
