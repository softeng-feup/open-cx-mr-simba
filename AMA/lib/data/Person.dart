import 'package:flutter/material.dart';

class Person {
  Person({this.key,
          this.name,
          this.affiliation,
          this.bio,
          this.url,
          this.photo});

  String key;
  String name;
  String affiliation;
  String bio;
  String url;
  Image photo; // use Image.network(linkFromJSONFile)
}