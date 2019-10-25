import 'package:ama/components/GenericContainer.dart';
import 'package:flutter/material.dart';
import '../constants/AppColors.dart' as AppColors;
import '../constants/Utility.dart' as Utility;

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.mainColor,
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
              padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
              child: GenericContainer(
                title: "AMA - Agenda Mobile App",
                text: Utility.aboutText,
              ),
            ),
          ],
        ),
      )
    );
  }
}

