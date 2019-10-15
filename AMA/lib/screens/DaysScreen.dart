import 'package:flutter/material.dart';
import '../components/DaysContainer.dart';
import '../constants/Dates.dart' as Dates;
import '../constants/AppColors.dart' as AppColors;

class DaysScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "<AMA - Agenda Mobile App>",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: AppColors.mainColor,
        
      ),
      drawer: Drawer(
          semanticLabel: "menu",
          child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 100.00,
              child: DrawerHeader(
                child: Text('Menu'),
                decoration: BoxDecoration(
                color: AppColors.mainColor,
                ),
              )
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
          ],
        ),

      ),
      body: Container(
          color: AppColors.backgroundColor,
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Center(
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 5.0),
                    child: GridView.count(
                      scrollDirection: Axis.vertical,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 30,
                      children: <Widget>[
                        DaysContainer(day: 1, date: Dates.date1),
                        DaysContainer(day: 2, date: Dates.date2),
                        DaysContainer(day: 3, date: Dates.date3),
                        DaysContainer(day: 4, date: Dates.date4),
                      ],
                    )),
              ))
            ],
          )),
    );
  }
}
