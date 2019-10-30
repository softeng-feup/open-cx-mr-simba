import 'dart:collection';
import 'package:ama/model/DayScheduleInfo.dart';
import 'package:ama/model/Model.dart';
import 'package:ama/model/Session.dart';
import 'json/JsonController.dart';
import 'json/JsonMapper.dart';
import '../constants/Utility.dart' as Utility;

class Controller {

  static Controller _instance;
  Model _model;

  Controller() {
    _model = new Model();
  }

  static Controller instance() {
    if(_instance == null)
      _instance = new Controller();

    return _instance;
  }


  DayScheduleInfo getDaySchedule(int day) {
    return _model.getSchedules().elementAt(day - 1);
  }


  String addSessionToSchedule(int day, Session session) {
    bool added = _model.getSchedules().elementAt(day - 1).getSessions().add(session);
    if(added)
      return "Session added to schedule";
    else
      return "Session already added to schedule";
  }


  String removeSessionFromSchedule(int day, Session session) {
    _model.getSchedules().elementAt(day - 1).getSessions().remove(session);
    return "Session deleted from schedule";
  }


  String getTextActivities(int day) {
    int numActivities = _model.getSchedules().elementAt(day - 1).getSessions().length;
    return numActivities.toString() + " " + (numActivities == 1 ? "activity" : "activities");
  }





  SplayTreeSet<Session> getDaySessions(String dateString) {
    return JsonMapper.sessionSet(JsonController().getJson(), dateString);
  }


  Future getJson() async {
    await JsonController().parseJsonFromURL(Utility.jsonURL);
  }

}