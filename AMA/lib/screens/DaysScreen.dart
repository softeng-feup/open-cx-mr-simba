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
                child: Text('Menu', style: TextStyle(color: Colors.white),),
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
              leading: Icon(Icons.info)
            ),
          ],
        ),

      ),
      body: 
      PageViewScreen()
      
      /*Container(
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
                        DayContainer(day: 1, date: Dates.date1),
                        DayContainer(day: 2, date: Dates.date2),
                        DayContainer(day: 3, date: Dates.date3),
                        DayContainer(day: 4, date: Dates.date4),
                      ],
                    )),
              ))
            ],
          )),*/
    );
  }
}
