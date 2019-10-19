import 'package:ama/screens/PageViewScreen.dart';
import 'package:flutter/material.dart';
import '../constants/AppColors.dart' as AppColors;

class DaysScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "<AMA - Agenda Mobile App>",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromRGBO(3, 44, 115, 1),
        ),
        drawer: Drawer(
          semanticLabel: "menu",
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                  height: 100.00,
                  child: DrawerHeader(
                    child: Text('Menu'),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                    ),
                  )),
              ListTile(
                  title: Text('About'),
                  onTap: () {
                    Navigator.pushNamed(context, '/about');
                  },
                  leading: Icon(Icons.info)),
            ],
          ),
        ),
        body: PageViewScreen()
        );
  }
}
