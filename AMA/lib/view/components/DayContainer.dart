import 'package:ama/constants/Dates.dart';
import 'package:ama/controller/Controller.dart';
import 'package:flutter/material.dart';

class MainScreenPage extends StatelessWidget {
  MainScreenPage({this.dayNo, this.date});

  final int dayNo;
  final Date date;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       key: Key("Calendar page"),
        onTap: () {
          String routeOnTap = "/day" + dayNo.toString() + "Screen";
          Navigator.pushNamed(context, routeOnTap);
        },
        child: Column(
          children: <Widget>[
            Align(
                alignment: Alignment.topCenter,
                child: new SmallCalendarPage(
                  date: date,
                  dayNo: dayNo,
                )),
          ],
        ));
  }
}

class SmallCalendarPage extends StatelessWidget {
  final Date date;
  final int dayNo;

  const SmallCalendarPage({
    Key key,
    this.date,
    this.dayNo,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 40 / 100,
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.circular(20),
        color: Colors.white,
        border: Border.all(width: 2),
      ),
      child: this.drawCalendar(context),
    );
  }


  Widget drawCalendar(BuildContext context) {

    String text = Controller.instance().getTextActivities(dayNo);

    return ClipRRect(
      borderRadius: new BorderRadius.circular(16),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: new Text(date.getWeekDay(), style: TextStyle(fontSize: 30)),
          backgroundColor: Colors.red,
          leading: Padding(
            padding: const EdgeInsets.all(8.5),
            child:
            Text("#" + dayNo.toString(), style: TextStyle(fontSize: 30), key: Key("identifierDay")),
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text(
                date.getDay(),
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.15,
                    color: Colors.black),
              ),
              Text(
                date.getMonthStr(),
                style: TextStyle(fontSize: 25, color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text( text,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  key: Key("numberOfActivitiesDay"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

