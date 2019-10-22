import 'dart:collection';
import 'package:ama/constants/Dates.dart';
import 'package:ama/data/Session.dart';

class DayScheduleInfo {
  DayScheduleInfo(int day, Date date) { this._day = day; this._date = date;}

  int _day;
  Date _date;
  SplayTreeSet<Session> _sessions = SplayTreeSet();

  SplayTreeSet<Session> getSessions() {
    return _sessions;
}

  int getDay() {
    return _day;
  }

  Date getDate() {
    return _date;
  }
}