import 'package:ama/RouteGenerator.dart';
import 'package:flutter/material.dart';
import 'controller/json/JsonController.dart';

// TODO: depois se calhar meter este controller dentro do controller principal
// TODO: cena das activities (meter tb no controller)

void main() async { 
  await JsonController().parseJsonFromURL('https://2019.programming-conference.org/dataexport/810b23a0-737b-4f74-9170-75d515274859/confero.json');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

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
