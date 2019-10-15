import 'package:flutter/material.dart';
import '../constants/AppColors.dart' as AppColors;

class DaysContainer extends StatefulWidget {
  DaysContainer({this.day, this.date});
  
  final int day;
  final String date;

  @override
  DaysContainerState createState() => DaysContainerState();
}



class DaysContainerState extends State<DaysContainer> {
  int numActivities = 0;
  String activityString = "activities";

  void changeNumActivities(int numActivities) {
      setState(() {
        this.numActivities = numActivities;

        if(this.numActivities == 1)
          this.activityString = "activity";
        else
          this.activityString = "activities";
      });
  }


  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        String routeOnTap = "/day" + widget.day.toString() + "Screen";
        Navigator.pushNamed(context, routeOnTap);
      },
      color: Colors.transparent,

      // elevation: 0,
      // animationDuration: Duration(seconds: 1),
      // hoverElevation: 10,
      // splashColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(18.0)),

      padding: EdgeInsets.all(0.0),
      child: Container(
        decoration: const BoxDecoration(

          borderRadius: BorderRadius.all(Radius.circular(18.0)),

        gradient: LinearGradient(
          colors: <Color>[
          Color(0xFF0D47A1),
          Color(0xFF1976D2),
          Color(0xFF0D47A1),
          ],
         ),
        ),

        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
                Text('Day ' + widget.day.toString(),
                  style: TextStyle(fontSize: 35, color: AppColors.mainColor),),

                Text(widget.date,
                  style: TextStyle(fontSize: 16, color: Colors.grey),),

                Text('$numActivities $activityString',
                  style: TextStyle(fontSize: 20, color: Colors.white),),
            ],
          ),
        ),
      ),

    );
  }
}