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
      body: Text("Ola"),
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
}
