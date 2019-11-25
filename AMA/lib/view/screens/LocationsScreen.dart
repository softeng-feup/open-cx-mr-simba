import 'dart:collection';

import 'package:ama/controller/Controller.dart';
import 'package:ama/model/ListSessionsInfo.dart';
import 'package:ama/model/Session.dart';
import 'package:ama/view/components/GenericContainer.dart';
import 'package:flutter/material.dart';
import '../../constants/AppColors.dart' as AppColors;
import '../../constants/Utility.dart' as Utility;

class LocationsScreen extends StatelessWidget {
  LocationsScreen({this.locations});

  final List<String> locations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text("All conference locations"),
        leading: IconButton(
          key: Key("Back button"),
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
          this.drawEmptyMessage(locations.length == 0),
          this._drawAllLocations(locations),
        ],
      ),
    ),
    );
  }


  Widget drawEmptyMessage(bool empty) {
    return Visibility(
      maintainSize: false,
      visible: empty,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: GenericContainer(
            title: Utility.noLocationsTitle,
            text: Utility.noLocationsText),
      ),
    );
  }

  Widget _drawAllLocations(List<String> locations) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(
              left: 10.0, right: 10.0, top: 10.0, bottom: 70.0),
          itemCount: locations.length,
          itemBuilder: (context, idx) {
            return FlatButton(
                padding: EdgeInsets.only(bottom: 10.0),
                child: GenericContainer(
                  title: "Location",
                  text: locations.elementAt(idx),
                  touchable: true,
                ),
                onPressed: () async {
                  SplayTreeSet<Session> set = await Controller.instance().getSessionsByLocation(locations.elementAt(idx));
                  Navigator.pushNamed(context, '/listSessionsScreen',
                        arguments: ListSessionsInfo("All sessions at " + locations.elementAt(idx), set));
                });
          }),
    );
  }
}