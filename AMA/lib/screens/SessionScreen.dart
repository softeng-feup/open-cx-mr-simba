import 'package:ama/components/GenericContainer.dart';
import 'package:ama/data/Session.dart';
import 'package:ama/json/JsonController.dart';
import 'package:ama/json/JsonMapper.dart';
import 'package:flutter/material.dart';
import '../constants/AppColors.dart' as AppColors;

class SessionScreen extends StatelessWidget {
  SessionScreen({this.session});

  final Session session;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text(session.type),
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
        child: ListView(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: GenericContainer(title: session.title, text: session.location),
            ),
            Padding(
              padding:
              const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: GenericContainer(title: session.day, text: session.timeString),
            ),
            if (session.description.isNotEmpty) Padding(
              padding:
              const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: GenericContainer(title: "Abstract", text: session.description),
            ),
            if (session.chairs != null) Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: FlatButton(
                  padding: EdgeInsets.all(0.0),
                  child: GenericContainer(
                      title: "Chairs", text: session.chairsString, touchable: true,),
                  onPressed: () => Navigator.pushNamed(context, '/personScreen',
                      arguments: JsonMapper.peopleWithKeys(
                          JsonController().getJson(), session.chairs))),
            ),
            if (session.items!= null) Padding(
              padding:
              const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: FlatButton(
                  padding: EdgeInsets.all(0.0),
                  child: GenericContainer(
                    title: "Items", text: "", touchable: true,),
                  onPressed: () => Navigator.pushNamed(context, '/itemsScreen',
                      arguments: JsonMapper.itemWithKeys(
                          JsonController().getJson(), session.items))),
            ),
          ],
        ),
      ),
    );
  }
}
