import 'package:ama/view/screens/MainScreenPager.dart';
import 'package:flutter/material.dart';
import '../../constants/AppColors.dart' as AppColors;

class DaysScreen extends StatelessWidget {
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
            ],
          ),
        ),
        body: Container(color: AppColors.backgroundColor,child: MainScreenPager()));
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
}
