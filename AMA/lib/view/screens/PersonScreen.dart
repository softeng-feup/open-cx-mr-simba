import 'package:ama/model/Person.dart';
import 'package:flutter/material.dart';
import '../../constants/AppColors.dart' as AppColors;

class PersonScreen extends StatelessWidget{
  final Person person;

  PersonScreen({this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text("Personal Information"),
        leading: IconButton(
          key: Key("Back button"),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }



}