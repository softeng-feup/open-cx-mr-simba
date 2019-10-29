import 'package:ama/constants/Dates.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class MainScreenPage extends StatelessWidget {
  MainScreenPage({this.dayNo, this.date});

  final int dayNo;
  final Date date;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                  activityCount: 0,
                )),
          ],
        ));
  }
}

class SmallCalendarPage extends StatefulWidget {
  final Date date;
  final int dayNo;
  final int activityCount;

  const SmallCalendarPage({
    Key key,
    this.date,
    this.dayNo,
    this.activityCount,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => SmallCalendarPageState(activityCount);
}

class SmallCalendarPageState extends State<SmallCalendarPage> {
  int activityCnt;
  String activityString;

  SmallCalendarPageState(activityCount) : this.activityCnt = activityCount;

  void incrementActivityCnt() {
    setState(() {
      this.activityCnt++;
    });
  }

  @override
  Widget build(BuildContext context) {
    activityString = (this.activityCnt == 1) ?  "activity" : "activities";

    return Container(
      height: MediaQuery.of(context).size.height * 40 / 100,
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.circular(20),
        color: Colors.white,
        border: Border.all(width: 2),
      ),
      child: this.drawCalendar(),
    );
  }


  Widget drawCalendar() {
    return ClipRRect(
      borderRadius: new BorderRadius.circular(16),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: new Text(widget.date.getWeekDay(), style: TextStyle(fontSize: 30)),
          backgroundColor: Colors.red,
          leading: Padding(
            padding: const EdgeInsets.all(8.5),
            child:
            Text("#" + widget.dayNo.toString(), style: TextStyle(fontSize: 30)),
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text(
                widget.date.getDay(),
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.15,
                    color: Colors.black),
              ),
              Text(
                widget.date.getMonthStr(),
                style: TextStyle(fontSize: 25, color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  widget.activityCount.toString() + " " + activityString,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
