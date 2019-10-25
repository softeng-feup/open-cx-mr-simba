import 'package:ama/components/GenericContainer.dart';
import 'package:ama/data/Person.dart';
import 'package:flutter/material.dart';
import '../constants/AppColors.dart' as AppColors;

class PersonScreen extends StatelessWidget {
  PersonScreen({this.people});

  final List<Person> people;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text("Pessoal"),
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
        child: Column(
          children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: GenericContainer(title: "Title:", text: people[0].name),
              ),
          ],
        ),
      ),
    );
  }
}