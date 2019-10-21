import 'package:ama/data/Person.dart';
import 'dart:convert';

class PersonJsonMapper {
  static Person fromJson(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    String name = json['Name'];
    String key = json['Key'];
    String affiliation = json['Affiliation'];
    String bio = json['Bffiliation'];
    String url = json['URL'];
    String imageURL = json['URLphoto'];

    return Person(key, name, affiliation, bio, url, imageURL);
  }
}
