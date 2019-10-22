import 'package:ama/data/Session.dart';

class SessionJsonMapper {
  static Session fromJsonMap(Map<String, dynamic> json) {
    return Session(
      title: json['Title'] as String,
      key: json['Key'],
      description: json['Abstract'],
      type: json['Type'],
      chairs: SessionJsonMapper.getStringList(json, "Chairs"),
      chairsString: json['ChairsString'] as String,
      items: SessionJsonMapper.getStringList(json, "Items"),
      location: json['Location'],
      timeString: json['Time'],
      day: json['Day']
    );
  }

  static List<String> getStringList(Map<String, dynamic> json, String key) {
    List<dynamic> dynamicList = json[key];
    List<String> strings = new List<String>();

    dynamicList.forEach((f) {
      strings.add(f);
    });

    return strings;
  }

  static List<Session> fromJsonArrayMap(Map<String, dynamic> jsonMap) {
    List<dynamic> dynamicList = jsonMap['Sessions'];
    List<Session> sessions = new List<Session>();

    dynamicList.forEach((f) {
      Session s = SessionJsonMapper.fromJsonMap(f);
      sessions.add(s);
    });

    return sessions;
  }
}
