import 'package:flutter/material.dart';

class DaysContainer extends StatelessWidget {
  DaysContainer({this.day, this.date});

  // vai ter o numero de atividades, por isso na verdade tera um state

  final int day;
  final String date;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {},
      padding: EdgeInsets.all(0.0),
      child: Container(
        decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
          Color(0xFF0D47A1),
          Color(0xFF1976D2),
          Color(0xFF42A5F5),
          ],
         ),
        ),


        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                Text('Day $day',
                  style: TextStyle(fontSize: 20, color: Colors.greenAccent),),

                Text('$date',
                  style: TextStyle(fontSize: 14, color: Colors.grey),),

                Text('0 activities',
                  style: TextStyle(fontSize: 16, color: Colors.white),),
            ],
          ),
        ),
      ),

    );
  }
}