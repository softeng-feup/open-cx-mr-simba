import 'package:ama/model/Session.dart';
import 'package:ama/view/components/GenericContainer.dart';
import 'package:flutter/material.dart';
import '../../constants/AppColors.dart' as AppColors;

class SessionScreen extends StatelessWidget {
  SessionScreen({this.session});

  final Session session;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text("Session Info"),
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
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: GenericContainer(title: "Title:", text: session.title),
              ),

            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: FlatButton(
                  padding: EdgeInsets.all(0.0),
                  child: GenericContainer(title: "Chairs:", text: "Tap to see more"),
                  onPressed: () => {}
                  ),
            ),
          ],
        ),
      ),
    );
  }
}