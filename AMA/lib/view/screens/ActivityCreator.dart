import 'package:ama/view/components/CreatorForm.dart';
import 'package:ama/view/components/GenericContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../constants/AppColors.dart' as AppColors;

class ActivityCreatorScreen extends StatefulWidget {
  @override
  ActivityCreatorScreenState createState() => ActivityCreatorScreenState();
}

class ActivityCreatorScreenState extends State<ActivityCreatorScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  Widget getAppBar() {
    return AppBar(
      title: Text(
        "Activity Creator",
        style: TextStyle(color: Colors.white),
        key: Key("Screen title"),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: AppColors.mainColor,
    );
  }

  Widget getBody() {

    return Container(
      color: AppColors.backgroundColor,
      child: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          GenericContainer(
              title: "Let's get busy...",
              text:
                  "Here you can create an activity of your own and add it to you schedule"),
          CreatorForm(),
        ],
      ),
    );
  }
}
