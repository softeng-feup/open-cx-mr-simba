import 'package:ama/constants/Dates.dart';

class Schedule {
  Schedule({this.day, this.date, this.sessions});

  int day;
  Date date;
  List<String> sessions;

  // passar uma lista de mapas que e um join entre Schedule e ScheduleSession
  Schedule.fromMap(List<Map<String, dynamic>> mapList) {
    this.day = mapList.elementAt(0)['scheduleDay'];
    this.date = new Date.fromDate(mapList.elementAt(0)['weekday'], mapList.elementAt(0)['date']);
    this.sessions = [];
    for(int i = 0; i < mapList.length; i++) {
      this.sessions.add(mapList.elementAt(i)['sessionKey']);
    }
  }


  // retorna uma lista de maps cujo primeiro elemento e a schedule em si e os seguintes sao entradas de ScheduleSession
  List<Map<String, dynamic>> toMap() {
    var scheduleMap = <String, dynamic>{
      'scheduleDay': this.day,
      'weekday': this.date.getWeekDay(),
      'date': this.date.toDateString()
    };
    List<Map<String, dynamic>> mapList = [];
    mapList.add(scheduleMap);
    for(int i = 0; i < mapList.length; i++) {
      var scheduleSessionMap = <String, dynamic>{
        'scheduleDay': this.day,
        'sessionKey': this.sessions.elementAt(i)
      };
      mapList.add(scheduleSessionMap);
    }
    return mapList;
  }
}