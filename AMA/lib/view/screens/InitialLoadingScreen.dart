import 'dart:io';

import 'package:ama/controller/Controller.dart';
import 'package:ama/view/components/GenericContainer.dart';
import 'package:flutter/material.dart';
import '../../constants/AppColors.dart' as AppColors;
import '../../constants/Utility.dart' as Utility;

class InitialLoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InitialLoadingScreenState();
  }
}

class InitialLoadingScreenState extends State<InitialLoadingScreen> {
  @override
  void initState() {
    super.initState();
    Controller.instance().initDatabase().then((success) {
        if(success)
          Navigator.of(context).pushReplacementNamed('/homeScreen');
        else
          _noInternetAlert(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: Column(
        children: <Widget> [
          Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 200.0, bottom: 50.0),
            child: GenericContainer(
              title: "Welcome to AMA",
              text: "Please wait...",
            ),
          ),
          CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.mainColor),
        ),
      ]),
    );
  }


  void _noInternetAlert(BuildContext context) {
        showDialog(context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(Utility.noInternetTitle),
                content: Text(Utility.noInternetText),
                actions: <Widget>[
                  FlatButton(
                    child: Text("OK"),
                    onPressed: () => exit(0),
                  )
                ],
              );
            }
        );
    }
}
