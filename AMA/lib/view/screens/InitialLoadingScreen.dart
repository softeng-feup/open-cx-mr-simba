import 'dart:async';
import 'package:flutter/material.dart';

class InitialLoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InitialLoadingScreenState();
  }
}

class InitialLoadingScreenState extends State<InitialLoadingScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
        ),
      ),
    );
  }

  Future loadData() async {
    Timer(Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.pushNamed(context, '/daysScreen');
  }
}

