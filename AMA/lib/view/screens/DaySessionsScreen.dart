import 'package:ama/components/SlidableSessionContainer.dart';
import 'package:ama/controller/Controller.dart';
import 'package:ama/model/DayScheduleInfo.dart';
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
          title: Text("Sessions for  " + sessionsInfo.getDate().toString()),
          leading: IconButton(
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
                onPressFunction: () {
                  String text = Controller.instance().removeSessionFromSchedule(sessionsInfo.getDay(), sessionsInfo.getSessions().elementAt(idx));

                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text(text)));
                },
              );
            })
    );
  }
}
