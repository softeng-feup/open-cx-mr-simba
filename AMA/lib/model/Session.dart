class Session extends Comparable<dynamic> {
  String key;
  String title;
  String chairsString; // name of the chair
  List<String> chairs; // chair key, so we can get the info about the chair in the json file
  List<String> items; // item keys, so we can get info about the these items in the json file
  String type;
  String day;
  DateTime startTime;
  String timeString;
  String location;
  String description;

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
    if (this.key == other.key) 
      return 0;
  
    return this.timeString.compareTo(other.timeString);
  }

  // passar uma lista de mapas que e um join entre Session, SessionItem e SessionChair
  Session.fromMap(List<Map<String, dynamic>> mapList) {
    this.key = mapList.elementAt(0)['sessionKey'];
    this.title = mapList.elementAt(0)['title'];
    this.chairsString = mapList.elementAt(0)['chairsString'];
    this.type = mapList.elementAt(0)['type'];
    this.day = mapList.elementAt(0)['day'];
    this.startTime = DateTime.fromMillisecondsSinceEpoch(mapList.elementAt(0)['startTime']);
    this.timeString = mapList.elementAt(0)['timeString'];
    this.location = mapList.elementAt(0)['location'];
    this.description = mapList.elementAt(0)['description'];
    this.chairs = [];
    this.items = [];
    for(int i = 0; i < mapList.length; i++) {
      this.chairs.add(mapList.elementAt(i)['personKey']);
      this.items.add(mapList.elementAt(i)['itemKey']);
    }
  }

  // apenas retorna o map referente a Session em si
  Map<String, dynamic> toMapSession() {
    var sessionMap = <String, dynamic>{
      'sessionKey': this.key,
      'title': this.title,
      'chairsString': this.chairsString,
      'type': this.type,
      'day': this.day,
      'startTime': this.startTime.millisecondsSinceEpoch,
      'timeString': this.timeString,
      'location': this.location,
      'description': this.description
    };
    return sessionMap;
  }

  // retorna maps com os chairs
  List<Map<String, dynamic>> toMapChairs() {
    List<Map<String, dynamic>> mapList = [];
    for (int i = 0; i < this.chairs.length; i++) {
      var sessionChairMap = <String, dynamic>{
        'sessionKey': this.key,
        'personKey': this.chairs.elementAt(i)
      };
      mapList.add(sessionChairMap);
    }
    return mapList;
  }


  // retorna maps com os items
  List<Map<String, dynamic>> toMapItems() {
    List<Map<String, dynamic>> mapList = [];
    for (int i = 0; i < this.items.length; i++) {
      var sessionItemMap = <String, dynamic>{
        'sessionKey': this.key,
        'itemKey': this.items.elementAt(i)
      };
      mapList.add(sessionItemMap);
    }
    return mapList;
  }
}


