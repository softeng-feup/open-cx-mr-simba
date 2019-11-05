import 'package:ama/RouteGenerator.dart';
import 'package:ama/controller/Controller.dart';
import 'package:args/args.dart';
import 'package:flutter/material.dart';
import 'constants/Utility.dart' as Utility;

void main(List<String> args) {
  var parser = new ArgParser();
  parser.addOption('urlPath', defaultsTo: 'normal', callback: (path) {
    String url;
    if(path == 'normal')
      url = Utility.jsonURL;
    else
      url = path;

    Controller.instance().updateURLPath(url);
  });

  parser.parse(args);
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
