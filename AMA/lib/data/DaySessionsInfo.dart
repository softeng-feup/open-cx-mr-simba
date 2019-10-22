import 'dart:collection';
import 'package:ama/constants/Dates.dart';
import 'Session.dart';

class DaySessionsInfo {
  DaySessionsInfo(Date date, SplayTreeSet<Session> daySessions, Function addFunction) {
    this._date = date;
    this._daySessions = daySessions;
    this.addFunction = addFunction;
  }

  Date _date;
  SplayTreeSet<Session> _daySessions;
  Function addFunction;

  SplayTreeSet<Session> getSessions() {
    return _daySessions;
  }

  Date getDate() {
    return _date;
  }
}