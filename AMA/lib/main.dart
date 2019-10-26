import 'package:ama/json/JsonController.dart';
import 'package:ama/RouteGenerator.dart';
import 'package:ama/data/Database.dart';
import 'package:flutter/material.dart';

void main() async { 
  await JsonController().parseLocalJson('resources/confero.json');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  static final Database database = new Database();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,

    );
  }
}
