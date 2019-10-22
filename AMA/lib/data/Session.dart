class Session extends Comparable<dynamic> {
  Session({this.key,
           this.title,
           this.chairStrings,
           this.chairKeys,
           this.itemKeys,
           this.type,
           this.day,
           this.startTime,
           this.timeString,
           this.location,
           this.description});

  String key;
  String title;
  List<String> chairStrings; // names of the chairs
  List<String> chairKeys; // chair keys, so we can get the info about the chairs in the json file
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
  int get hashCode => this.key.hashCode;

  @override
  int compareTo(other) {
    if(this.key == other.key)
      return 0;

    return this.timeString.compareTo(other.timeString);
  }
}