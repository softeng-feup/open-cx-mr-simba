import 'dart:collection';

import 'package:ama/controller/Controller.dart';
import 'package:ama/model/DayScheduleInfo.dart';
import 'package:ama/model/Session.dart';
import 'package:ama/view/components/SlidableSessionContainer.dart';
import 'package:flutter/material.dart';
import '../../constants/AppColors.dart' as AppColors;

class DaySessionsScreen extends StatefulWidget {
  DaySessionsScreen({this.sessionsInfo});

  final DayScheduleInfo sessionsInfo;

  DaySessionsScreenState createState() => DaySessionsScreenState(sessionsInfo.getSessions());
}


class DaySessionsScreenState extends State<DaySessionsScreen> {
  DaySessionsScreenState(SplayTreeSet<Session> sessions) {
    this._sessions = sessions;
  }

  SplayTreeSet<Session> _sessions;
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  Future _updateDaySessions() async {
    await Controller.instance().extractJson();

    SplayTreeSet<Session> newSessions = await Controller.instance().getDaySessions(
        widget.sessionsInfo.getDate().toDateString());

    if(this.mounted) {
      setState(() {
        _sessions = newSessions;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text("Sessions - " + widget.sessionsInfo.getDate().toString()),
        leading: IconButton(
          key: Key("Back button"),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh, size: 30),
            color: Colors.white,
            onPressed: () async {
                await _updateDaySessions();
                if(this.mounted) {
                  _scaffoldKey.currentState.showSnackBar(
                      SnackBar(content: Text("Sessions updated with sucess")));
                }
              },
          )
        ],
      ),
      body: this.drawSessionsList(),
    );
  }


  Widget drawSessionsList() {
    return Container(
        color: AppColors.backgroundColor,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
            itemCount: _sessions.length,
            itemBuilder: (context, idx) {
              return SlidableSessionContainer(
                session: _sessions.elementAt(idx),
                icon: Icons.check,
                color: Colors.green,
                onPressFunction: () {
                  String text = Controller.instance().addSessionToSchedule(widget.sessionsInfo.getDay(), _sessions.elementAt(idx));
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text(text)));
                },
              );
            })
    );
  }

}