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
      body: SearchSessions(sessionsInfo),
    );
  }
}

class SearchSessions extends StatefulWidget {
  final DayScheduleInfo sessionsInfo;

  const SearchSessions(this.sessionsInfo);

  @override
  State<StatefulWidget> createState() => new SearchSessionsState(sessionsInfo);
}

class SearchSessionsState extends State<SearchSessions> {
  final DayScheduleInfo sessionsInfo;
  TextEditingController controller = new TextEditingController();
  String filter;

  SearchSessionsState(this.sessionsInfo) {
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: new EdgeInsets.only(left: 20.0, right: 20.0),
        child: TextField(
            decoration: new InputDecoration(labelText: "Search", icon: Icon(Icons.search), border: InputBorder.none),
            controller: controller),
      ),
      Expanded(
          child: Container(
              color: AppColors.backgroundColor,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                  itemCount: sessionsInfo.getSessions().length,
                  itemBuilder: (context, idx) {
                    if (filter == null ||
                        filter == "" ||
                        sessionsInfo.getSessions().elementAt(idx).title.toLowerCase().contains(filter.toLowerCase()))
                      return SlidableSessionContainer(
                        session: sessionsInfo.getSessions().elementAt(idx),
                        icon: Icons.check,
                        color: Colors.green,
                        onPressFunction: () async {
                          String text = await Controller.instance()
                              .addSessionToSchedule(sessionsInfo.getDay(),
                                  sessionsInfo.getSessions().elementAt(idx));
                          Scaffold.of(context)
                              .showSnackBar(SnackBar(content: Text(text)));
                        });
                    else
                      return Container();

                  })))]);
  }
}
