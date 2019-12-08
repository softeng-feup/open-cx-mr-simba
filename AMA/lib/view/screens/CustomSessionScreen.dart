import 'package:ama/controller/Controller.dart';
import 'package:ama/model/Session.dart';
import 'package:ama/view/components/GenericContainer.dart';
import 'package:ama/view/components/GenericTitle.dart';
import 'package:flutter/material.dart';
import '../../constants/AppColors.dart' as AppColors;

class CustomSessionScreen extends StatelessWidget {
  CustomSessionScreen({this.session});

  final Session session;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text(session.title),
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
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: GenericTitle(
                  title: session.title,
                  padding: EdgeInsets.all(6.0),
                  margin: EdgeInsets.only(top: 10.0),
                  style: TextStyle(
                      color: AppColors.mainColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 25)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: GenericContainer(
                  title: session.timeString, text: session.day),
            ),

            (session.location != "") ? 
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: GenericContainer(
                  title: "Location", text: session.location),
            ) : Container(),

            if ((session.description != null) && session.description.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: GenericContainer(
                    title: "Description", text: session.description),
              ),
            
          ],
        ),
      ),
    );
  }
}
