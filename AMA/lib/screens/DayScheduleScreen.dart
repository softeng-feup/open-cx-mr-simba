import 'dart:collection';

import 'package:ama/components/GenericContainer.dart';
import 'package:ama/components/SlidableSessionContainer.dart';
import 'package:ama/data/DayScheduleInfo.dart';
import 'package:ama/data/DaySessionsInfo.dart';
import 'package:ama/data/Session.dart';
import 'package:flutter/material.dart';
import '../constants/AppColors.dart' as AppColors;
import '../constants/Utility.dart' as Utility;

class DayScheduleScreen extends StatefulWidget {
  DayScheduleScreen({this.info});

  final DayScheduleInfo info;

  @override
  DayScheduleScreenState createState() => DayScheduleScreenState();
}

class DayScheduleScreenState extends State<DayScheduleScreen> {
  bool _removeSession(Session session) {
    bool removed;

    setState(() {
      removed = widget.info.getSessions().remove(session);
    });

    return removed;
  }

  bool _addSession(Session session) {
    bool added;

    setState(() {
      added = widget.info.getSessions().add(session);
    });

    return added;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: Text("Day " + widget.info.getDay().toString() + " Schedule"),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          color: AppColors.backgroundColor,
          child: Column(
            children: <Widget>[
              Visibility(
                maintainSize: false,
                visible: (widget.info.getSessions().length == 0),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: GenericContainer(
                      title: Utility.noSessionsTitle,
                      text: Utility.noSessionsText),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10.0, bottom: 70.0),
                    itemCount: widget.info.getSessions().length,
                    itemBuilder: (context, idx) {
                      return SlidableSessionContainer(
                        session: widget.info.getSessions().elementAt(idx),
                        icon: Icons.delete,
                        color: Colors.red,
                        onPressFunction: () {
                          _removeSession(
                              widget.info.getSessions().elementAt(idx));
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Session deleted from schedule")));
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {

              // TODO: usar funcoes json para extrair as sessoes de cada dia
              SplayTreeSet<Session> set = SplayTreeSet();


              Navigator.pushNamed(context, '/daySessionsScreen',
                  arguments:
                      DaySessionsInfo(widget.info.getDate(), set, _addSession));
            }, // adicionar depois push para SessionsScreen (ir ao json buscar as sessoes desse dia)
            backgroundColor: AppColors.mainColor,
            foregroundColor: Colors.white,
            elevation: 20.0,
            icon: Icon(Icons.add),
            label: Text(
              "ADD",
              style: TextStyle(fontSize: 25),
            )));
  }
}
