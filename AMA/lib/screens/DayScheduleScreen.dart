import 'package:ama/data/Session.dart';
import 'package:ama/json/JsonController.dart';
import 'package:ama/json/SessionJsonMapper.dart';
import 'package:flutter/material.dart';
import '../constants/AppColors.dart' as AppColors;
import '../components/ActivityContainer.dart';

class DayScheduleScreen extends StatefulWidget {
  DayScheduleScreen({this.day});

  final int day;

  @override
  DayScheduleScreenState createState() => DayScheduleScreenState();
}

class DayScheduleScreenState extends State<DayScheduleScreen> {

  Set<Session> sessions = Set.from([]); // sessions selected for that day

  bool removeSession(Session session) {
    bool removed;

    setState(() {
      removed = sessions.remove(session);
    });

    return removed;
  }

  bool addSession(Session session) {
    bool added;

    setState(() {
      added = sessions.add(session);
    });

    return added;
  }

  List<Widget> _buildActivityContainerList() {
    List<Session> sessions = SessionJsonMapper.fromJsonArrayMap(JsonController().getJson());
    List<Widget> widgets = List<Widget>();

    sessions.forEach((f) {
      widgets.add(ActivityContainer(activity: f));
    });

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text("Day " + widget.day.toString() + " Screen"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: 
        Container(

          color: AppColors.backgroundColor,
          // aqui deve-se fazer display de todas as sessoes do dia

          child: ListView(

            scrollDirection: Axis.vertical,

              padding: const EdgeInsets.all(10),

            children: _buildActivityContainerList(),

          ),
        ),
    );
  }
}
