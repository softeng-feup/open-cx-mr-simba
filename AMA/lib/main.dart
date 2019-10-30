import 'package:ama/RouteGenerator.dart';
import 'package:ama/controller/Controller.dart';
import 'package:flutter/material.dart';

void main() async { 
  await Controller.instance().getJson();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

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
