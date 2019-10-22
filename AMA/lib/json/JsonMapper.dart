import 'dart:collection';

import '../data/Person.dart';
import '../data/Session.dart';

class JsonMapper {
  static List<String> stringList(Map<String, dynamic> json, String key) {
    List<dynamic> dynamicList = json[key];
    if (dynamicList == null) return null;
    
    List<String> strings = new List<String>();

    dynamicList.forEach((f) {
      strings.add(f);
    });

    return strings;
  }

  static Person person(Map<String, dynamic> json) {
    return Person(
      name:  json['Name'],
      key: json['Key'],
      affiliation: json['Affiliation'],
      bio: json['Bio'],
      url: json['URL'],
      imageURL: json['URLphoto']
    );
  }

  static Map<String, Person> personMap(Map<String, dynamic> json) {
    List<dynamic> dynamicList = json['People'];
    Map<String, Person> people = Map<String, Person>();

    dynamicList.forEach((f) {
      Person p = JsonMapper.person(f);
      people[p.key] = p;
    });

    return people;
  }

  static Session session(Map<String, dynamic> json) {
    return Session(
      title: json['Title'] as String,
      key: json['Key'],
      description: json['Abstract'],
      type: json['Type'],
      chairs: JsonMapper.stringList(json, "Chairs"),
      chairsString: json['ChairsString'] as String,
      items: JsonMapper.stringList(json, "Items"),
      location: json['Location'],
      startTime: DateTime.parse(json['Day'] + ' ' + json['Time'].substring(0, 5) + ':00'),
      timeString: json['Time'],
      day: json['Day']
    );
  }

  static SplayTreeSet<Session> sessionSet(Map<String, dynamic> jsonMap) {
    List<dynamic> dynamicList = jsonMap['Sessions'];
    SplayTreeSet<Session> sessions = SplayTreeSet<Session>();

    dynamicList.forEach((f) {
      Session s = JsonMapper.session(f);
      sessions.add(s);
    });

    return sessions;
  }
}