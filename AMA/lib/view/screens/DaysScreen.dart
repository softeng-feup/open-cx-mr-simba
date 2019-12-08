import 'package:ama/controller/Controller.dart';
import 'package:ama/view/screens/MainScreenPager.dart';
import 'package:flutter/material.dart';
import '../../constants/AppColors.dart' as AppColors;

class DaysScreen extends StatefulWidget {
  @override
  State<DaysScreen> createState() {
    return DaysScreenState();
  }
}

class DaysScreenState extends State<DaysScreen> {
  @override
  void initState() {
    super.initState();
    Controller.instance().getAppLaunchDetails().then((details) {
      if (details.didNotificationLaunchApp && (details.payload != null)) {
        Controller.instance()
            .getSessionWithKey(details.payload)
            .then((session) {
          Navigator.pushNamed(context, '/sessionScreen', arguments: session);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "<AMA - Agenda Mobile App>",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.mainColor,
        ),
        drawer: Drawer(
          semanticLabel: "menu",
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                  height: 100.00,
                  child: DrawerHeader(
                    child: Text('Menu', style: TextStyle(color: Colors.white)),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                    ),
                  )),
              this.drawAboutTile(context),
              this.drawSessionSearch(context),
              this.drawLocations(context),
              this.drawActivityCreator(context),
            ],
          ),
        ),
        body: Container(
            color: AppColors.backgroundColor, child: MainScreenPager()));
  }

  Widget drawAboutTile(BuildContext context) {
    return ListTile(
        key: Key("About tile"),
        title: Text('About', style: TextStyle(color: Colors.black)),
        onTap: () {
          Navigator.pushNamed(context, '/about');
        },
        leading: Icon(Icons.info));
  }

  Widget drawSessionSearch(BuildContext context) {
    return ListTile(
        key: Key("Session search tile"),
        title: Text('Session Search', style: TextStyle(color: Colors.black)),
        onTap: () {
          Navigator.pushNamed(context, '/bluetoothScreen');
        },
        leading: Icon(Icons.bluetooth));
  }

  Widget drawLocations(BuildContext context) {
    return ListTile(
        key: Key("Locations tile"),
        title: Text('Locations', style: TextStyle(color: Colors.black)),
        onTap: () async {
          List<String> locations =
              await Controller.instance().getLocationsByOrder();
          Navigator.pushNamed(context, '/locationsScreen',
              arguments: locations);
        },
        leading: Icon(Icons.location_on));
  }

  Widget drawActivityCreator(BuildContext context) {
    return ListTile(
        key: Key("Activity creator tile"),
        title: Text('Activity Creator', style: TextStyle(color: Colors.black)),
        onTap: () async {
          Navigator.pushNamed(context, '/activityCreator');
        },
        leading: Icon(Icons.local_activity));
  }
}
