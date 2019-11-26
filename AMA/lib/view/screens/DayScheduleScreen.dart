import 'dart:collection';
import 'package:ama/controller/Controller.dart';
import 'package:ama/model/DayScheduleInfo.dart';
import 'package:ama/model/ListSessionsInfo.dart';
import 'package:ama/model/Session.dart';
import 'package:ama/view/components/GenericContainer.dart';
import 'package:ama/view/components/SlidableSessionContainer.dart';
import 'package:flutter/material.dart';
import '../../constants/AppColors.dart' as AppColors;
import '../../constants/Utility.dart' as Utility;

class DayScheduleScreen extends StatefulWidget {
  DayScheduleScreen({this.schedule});

  final DayScheduleInfo schedule;

  @override
  DayScheduleScreenState createState() => DayScheduleScreenState();
}

class DayScheduleScreenState extends State<DayScheduleScreen> {
  Future<String> _removeSession(Session session) async {
    String text = await Controller.instance().removeSessionFromSchedule(widget.schedule.getDay(), session);

    setState(() {});
    return text;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: AppColors.mainColor,
      title: Text("Day " + widget.schedule.getDay().toString() + " Schedule"),
      leading: IconButton(
        key: Key("Back button"),
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ),
        body: Container(
          color: AppColors.backgroundColor,
          child: Column(
            children: <Widget>[
              this.drawEmptyMessage(),
              this.drawList(),
            ],
          ),
        ),
      floatingActionButton: this.drawAddButton(),
    );
  }

  Widget drawEmptyMessage() {
    return Visibility(
      maintainSize: false,
      visible: (widget.schedule.getSessions().length == 0),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: GenericContainer(
            title: Utility.noSessionsTitle,
            text: Utility.noSessionsText),
      ),
    );
  }


  Widget drawList() {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(
              left: 10.0, right: 10.0, top: 10.0, bottom: 70.0),
          itemCount: widget.schedule.getSessions().length,
          itemBuilder: (context, idx) {
            return SlidableSessionContainer(
              session: widget.schedule.getSessions().elementAt(idx),
              icon: Icons.delete,
              color: Colors.red,
              onPressFunction: () async {
                String text = await _removeSession( widget.schedule.getSessions().elementAt(idx));
                Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text(text)));
              },
            );
          }),
    );
  }


  Widget drawAddButton() {
    return FloatingActionButton.extended(
        key: Key("Adding button"),
        onPressed: () async {
          SplayTreeSet<Session> set = await Controller.instance().getDaySessions(widget.schedule.getDate().toDateString());
          if(this.mounted) {
            Navigator.pushNamed(context, '/listSessionsScreen',
                arguments: ListSessionsInfo("Sessions - " + widget.schedule.getDate().toDateString(), set));
            }
          },
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
        elevation: 20.0,
        icon: Icon(Icons.add),
        label: Text(
          "ADD",
          style: TextStyle(fontSize: 25),
        )
    );
  }
}
