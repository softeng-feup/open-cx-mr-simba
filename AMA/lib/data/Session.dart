class Session {
  final String key;
  final String title;
  final String chairsString; // name of the chair
  final List<String> chairs; // chair key, so we can get the info about the chair in the json file
  final List<String> items; // item keys, so we can get info about the these items in the json file
  final String type;
  final String day;
  final DateTime startTime;
  final String timeString;
  final String location;
  final String description;

  Session({this.key,
           this.title,
           this.chairsString,
           this.chairs,
           this.items,
           this.type,
           this.day,
           this.startTime,
           this.timeString,
           this.location,
           this.description});

  @override
  bool operator==(other) {
    return this.key == other.key;
  }

  @override
  int get hashCode => this.key.hashCode;

  @override
  int compareTo(other) {
    if (this.key == other.key) return 0;
    
    return this.timeString.compareTo(other.timeString);
  }
}


