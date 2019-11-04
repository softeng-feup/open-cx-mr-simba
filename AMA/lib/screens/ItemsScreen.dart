import 'package:ama/components/GenericContainer.dart';
import 'package:ama/data/Item.dart';
import 'package:flutter/material.dart';
import '../constants/AppColors.dart' as AppColors;

class ItemsScreen extends StatelessWidget {
  ItemsScreen({this.items});

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: Text("Items"),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),

        body: Container(
            color: AppColors.backgroundColor,
            child: ListView.builder(
                scrollDirection: Axis.vertical,

                itemCount: items.length,
                itemBuilder: (context, idx) {
                  return Padding(
                  padding: EdgeInsets.all(10),
                  child: GenericContainer(
                      title: items.elementAt(idx).title,
                      text: items.elementAt(idx).peopleString
                  ));
                })));
  }
}