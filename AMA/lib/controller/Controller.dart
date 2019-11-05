import 'dart:collection';
import 'package:ama/controller/bluetooth/BluetoothController.dart';
import 'package:ama/model/DayScheduleInfo.dart';
import 'package:ama/model/Item.dart';
import 'package:ama/model/Model.dart';
import 'package:ama/model/Person.dart';
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


  // ----------------------------
  // regular controller methods
  // ----------------------------

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




  // ----------------------------
  // json methods
  // ----------------------------

  void updateURLPath(String url) {
    _model.setJsonURL(url);
  }

  Future<SplayTreeSet<Session>> getDaySessions(String dateString) async {
    return JsonMapper.sessionSet(await JsonController().getJson(_model.getJsonURL()), dateString);
  }

  Future extractJson() async {
    await JsonController().parseJsonFromURL(_model.getJsonURL());
  }

  Future<List<Person>> getPeopleWithKeys(List<String> chairs) async {
    return JsonMapper.peopleWithKeys(await JsonController().getJson(_model.getJsonURL()), chairs);
  }

  Future<List<Item>> getItemsWithKeys(List<String> items) async {
    return JsonMapper.itemWithKeys(await JsonController().getJson(_model.getJsonURL()), items);
  }

  // ----------------------------
  // bluetooth methods
  // ----------------------------

  Future<bool> isBluetoothAvailable() async {
    final aux = await BluetoothController.instance().isBluetoothAvailable();
    return aux;
  }

  Future<bool> isBluetoothEnabled() async {
    final aux = await BluetoothController.instance().isBluetoothEnabled();
    
    return aux;
  }

  Future<bool> isBluetoothOK() async {

    final aux1 = await BluetoothController.instance().isBluetoothEnabled();
    final aux2 = await BluetoothController.instance().isBluetoothAvailable();
    
    return aux1 && aux2;
  }

  List<String> searchForBeaconLocations()  {
    BluetoothController.instance().searchForBeacons();
    // TODO: ir buscar valores das localizacoes aos beacons
    return [];
  }

  // TODO: verificar que esta bem
  Future<SplayTreeSet<Session>> getSessionsNearby(List<String> locations) async {
    DateTime currentTime = new DateTime.now();
    String currentDateString = currentTime.toString().substring(0, 10);
    SplayTreeSet<Session> nearbySessions = SplayTreeSet();
    for(String location in locations) {
      SplayTreeSet<Session> sessionsInLocation = JsonMapper.sessionSetInLocation(await JsonController().getJson(_model.getJsonURL()), currentDateString, location);
      sessionsInLocation.forEach((s) {
          DateTime startTime = s.startTime;
          if(startTime.isAfter(currentTime) && ((startTime.difference(currentTime)).inMinutes <= Utility.numMinutesForNotif)) {
            nearbySessions.add(s);
          }
      });
    }
    return nearbySessions;
  }

}