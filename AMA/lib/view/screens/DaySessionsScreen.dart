import 'package:ama/controller/Controller.dart';
import 'package:ama/model/DayScheduleInfo.dart';
import 'package:ama/view/components/SlidableSessionContainer.dart';
import 'package:flutter/material.dart';
import '../../constants/AppColors.dart' as AppColors;

class DaySessionsScreen extends StatelessWidget {
  DaySessionsScreen({this.sessionsInfo});

  final DayScheduleInfo sessionsInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text("Sessions - " + sessionsInfo.getDate().toString()),
        leading: IconButton(
          key: Key("Back button"),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
            itemCount: sessionsInfo.getSessions().length,
            itemBuilder: (context, idx) {
              return SlidableSessionContainer(
                session: sessionsInfo.getSessions().elementAt(idx),
                icon: Icons.check,
                color: Colors.green,
                onPressFunction: () async {
                  String text = await Controller.instance().addSessionToSchedule(sessionsInfo.getDay(), sessionsInfo.getSessions().elementAt(idx));
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text(text)));
                },
              );
            })
    );
  }
}