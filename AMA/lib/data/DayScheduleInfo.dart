import 'package:ama/data/Session.dart';

class DayScheduleInfo {
  DayScheduleInfo(int day) { this._day = day; }

  int _day;
  Set<Session> _sessions = Set.from([]);

  Set<Session> getSessions() {
    return _sessions;
}

  int getDay() {
    return _day;
  }
}