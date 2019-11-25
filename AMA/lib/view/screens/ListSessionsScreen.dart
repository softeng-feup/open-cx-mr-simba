import 'dart:collection';

import 'package:ama/controller/Controller.dart';
import 'package:ama/model/ListSessionsInfo.dart';
import 'package:ama/model/Session.dart';
import 'package:ama/view/components/SlidableSessionContainer.dart';
import 'package:flutter/material.dart';
import '../../constants/AppColors.dart' as AppColors;

class ListSessionsScreen extends StatelessWidget {
  ListSessionsScreen({this.sessionsInfo});

  final ListSessionsInfo sessionsInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text(sessionsInfo.getTitle()),
        leading: IconButton(
          key: Key("Back button"),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SearchSessions(sessionsInfo.getSessions()),
    );
  }
}

class SearchSessions extends StatefulWidget {
  final SplayTreeSet<Session> sessionsInfo;

  const SearchSessions(this.sessionsInfo);

  @override
  State<StatefulWidget> createState() => new SearchSessionsState(sessionsInfo);
}

class SearchSessionsState extends State<SearchSessions> {
  final SplayTreeSet<Session> sessionsInfo;
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
                  itemCount: sessionsInfo.length,
                  itemBuilder: (context, idx) {
                    if (filter == null ||
                        filter == "" ||
                        sessionsInfo.elementAt(idx).title.toLowerCase().contains(filter.toLowerCase()))
                      return SlidableSessionContainer(
                        session: sessionsInfo.elementAt(idx),
                        icon: Icons.check,
                        color: Colors.green,
                        onPressFunction: () async {
                          String text = await Controller.instance()
                              .addSessionToSchedule(sessionsInfo.elementAt(idx));
                          Scaffold.of(context)
                              .showSnackBar(SnackBar(content: Text(text)));
                        });
                    else
                      return Container();

                  })))]);
  }
}
