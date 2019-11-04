
import 'package:ama/model/Session.dart';
import 'package:flutter/material.dart';
import '../../constants/AppColors.dart' as AppColors;

class SessionContainer extends StatelessWidget {
  SessionContainer({this.activity});

  final Session activity;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return FlatButton(
      padding: const EdgeInsets.all(0.0),
      onPressed: () {
        Navigator.pushNamed(context, '/sessionScreen', arguments: activity);
      },

      child: Container(
          width: deviceWidth * 0.95,
          height: 150,
          decoration: BoxDecoration(
              color: AppColors.containerColor,
              borderRadius: BorderRadius.all(Radius.circular(18.0))),
          child: Column(
            children: <Widget>[
              this.drawTitle(),
              Expanded(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    this.drawType(),
                    this.drawDay(),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  this.drawLocation(),
                  this.drawTime(),
                ],
              )
            ],
          ),
      ),
    );
  }


  Widget drawTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
      child: Text(
        activity.title,
        key: Key("Session title"),
        style: TextStyle(
          color: AppColors.mainColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }


  Widget drawType() {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: RichText(
          text: TextSpan(
              style: TextStyle(
                  color: AppColors.mainColor, fontSize: 17),
              children: <TextSpan>[
                TextSpan(
                    text: "Type: ",
                    style:
                    TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: activity.type)
              ]),
        ),
      ),
    );
  }


  Widget drawDay() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        activity.day,
        style: TextStyle(color: Colors.grey, fontSize: 17),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget drawLocation() {
    return Expanded(
      flex: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 12.0, horizontal: 15.0),
        child: RichText(
          text: TextSpan(
              style: TextStyle(
                  color: AppColors.mainColor, fontSize: 17),
              children: <TextSpan>[
                TextSpan(
                    text: "Location: ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: activity.location)
              ]),
        ),
      ),
    );
  }

  Widget drawTime() {
    return Expanded(
      flex: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 12.0, horizontal: 15.0),
        child: Text(
          activity.timeString,
          style: TextStyle(
              color: AppColors.mainColor,
              fontSize: 18,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }
}
