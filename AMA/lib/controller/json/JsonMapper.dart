import 'dart:collection';
import 'package:ama/model/Item.dart';
import 'package:ama/model/Person.dart';
import 'package:ama/model/Session.dart';

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
      name:  json['Name'] as String,
      key: json['Key'] as String,
      affiliation: json['Affiliation'] as String,
      bio: json['Bio'] as String,
      url: json['URL'] as String,
      imageURL: json['URLphoto'] as String
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

  static List<Person> peopleWithKeys(Map<String, dynamic> json, List<String> keys) {
    Map<String, Person> allPeople = JsonMapper.personMap(json);
    List<Person> people = List<Person>();

    keys.forEach((k) {
      people.add(allPeople[k]);
    });
  
    return people;
  }


  static Session session(Map<String, dynamic> json) {
    return Session(
      title: json['Title'] as String,
      key: json['Key'] as String,
      description: json['Abstract'] as String,
      type: json['Type'] as String,
      chairs: JsonMapper.stringList(json, "Chairs"),
      chairsString: json['ChairsString'] as String,
      items: JsonMapper.stringList(json, "Items"),
      location: json['Location'] as String,
      startTime: DateTime.parse(json['Day'] + ' ' + json['Time'].substring(0, 5) + ':00'),
      timeString: json['Time'] as String,
      day: json['Day'] as String
    );
  }

  static SplayTreeSet<Session> sessionSet(Map<String, dynamic> jsonMap, String date) {
    List<dynamic> dynamicList = jsonMap['Sessions'];
    SplayTreeSet<Session> sessions = SplayTreeSet<Session>();

    dynamicList.forEach((f) {
      Session s = JsonMapper.session(f);
      if (s.day == date)
        sessions.add(s);
    });

    return sessions;
  }

  static SplayTreeSet<Session> sessionSetInLocation(Map<String, dynamic> jsonMap, String date, String location) {
    List<dynamic> dynamicList = jsonMap['Sessions'];
    SplayTreeSet<Session> sessions = SplayTreeSet<Session>();

    dynamicList.forEach((f) {
      Session s = JsonMapper.session(f);
      if (s.day == date && s.location == location)
        sessions.add(s);
    });

    return sessions;
  }

  static Item item(Map<String, dynamic> json) {
    return Item(
      title: json['Title'] as String,
      key: json['Key'],
      description: json['Abstract'],
      type: json['Type'],
      authors: JsonMapper.stringList(json, "Authors"),
      peopleString: json['PersonsString'] as String,
      affiliations: JsonMapper.stringList(json, "Affiliations"),
      url: json['URL'] as String,
      affiliationString: json['AffiliationsString']
    );
  }

  static Map<String, Item> itemMap(Map<String, dynamic> json) {
    List<dynamic> dynamicList = json['Items'];
    Map<String, Item> items = Map<String, Item>();

    dynamicList.forEach((f) {
      Item i = JsonMapper.item(f);
      items[i.key] = i;
    });

    return items;
  }

  static List<Item> itemWithKeys(Map<String, dynamic> json, List<String> keys) {
    Map<String, Item> allItems = JsonMapper.itemMap(json);
    List<Item> items = List<Item>();

    keys.forEach((k) {
      items.add(allItems[k]);
    });
  
    return items;
  }
}