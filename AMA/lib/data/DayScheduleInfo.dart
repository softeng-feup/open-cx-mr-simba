import 'dart:collection';

import 'package:ama/data/Session.dart';

class DayScheduleInfo {
  DayScheduleInfo(int day) { this._day = day; }

  int _day;
  SplayTreeSet<Session> _sessions = SplayTreeSet();

  SplayTreeSet<Session> getSessions() {
    return _sessions;
}

  int getDay() {
    return _day;
  }
}