import 'package:ama/controller/Controller.dart';
import 'package:ama/view/components/GenericContainer.dart';
import 'package:flutter/material.dart';
import '../../constants/AppColors.dart' as AppColors;
import '../../constants/Utility.dart' as Utility;

class UpdateInformationScreen extends StatefulWidget {
  @override
  State<UpdateInformationScreen> createState() {
    return UpdateInformationScreenState();
  }
}

class UpdateInformationScreenState extends State<UpdateInformationScreen> {
  @override
  void initState() {
    super.initState();
    Controller.instance().updateInformation().then((success) {
        if(success) {
          Navigator.of(context).pushReplacementNamed('/homeScreen');
        }
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
              title: "Updating information",
              text: "Please wait...",
            ),
          ),
          Image(image: AssetImage("assets/images/AMA.gif"))
      ]),
    );
  }


  void _noInternetAlert(BuildContext context) {
        showDialog(context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(Utility.noInternetTitle),
                content: Text(Utility.noInternetTextUpdate),
                actions: <Widget>[
                  FlatButton(
                    child: Text("OK"),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              );
            }
        );
    }
}
