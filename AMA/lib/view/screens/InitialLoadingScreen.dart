import 'package:ama/controller/Controller.dart';
import 'package:ama/view/components/GenericContainer.dart';
import 'package:flutter/material.dart';
import '../../constants/AppColors.dart' as AppColors;

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
    Controller.instance().initDatabase().then((result) {
      Navigator.of(context).pushNamed('/homeScreen');
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
}
