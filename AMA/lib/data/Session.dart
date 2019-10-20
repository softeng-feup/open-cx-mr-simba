class Session {
  Session({this.key,
           this.title,
           this.chairString,
           this.chairKey,
           this.itemKeys,
           this.type,
           this.day,
           this.startTime,
           this.timeString,
           this.location,
           this.description});

  String key;
  String title;
  String chairString; // name of the chair
  String chairKey; // chair key, so we can get the info about the chair in the json file
  List<String> itemKeys; // item keys, so we can get info about the these items in the json file
  String type;
  String day;
  DateTime startTime; // use DateTime.parse(String) to initialize the time field
  String timeString;
  String location;
  String description;


  @override
  bool operator ==(other) {
    return this.key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}