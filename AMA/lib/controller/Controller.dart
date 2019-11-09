import 'dart:collection';
import 'package:ama/controller/bluetooth/BluetoothController.dart';
import 'package:ama/controller/database/DatabaseController.dart';
import 'package:ama/controller/database/DatabaseMapper.dart';
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


  // -----------------------------------------
  // regular controller (and database) methods
  // -----------------------------------------


  DayScheduleInfo getDaySchedule(int day) {
    return _model.getSchedules().elementAt(day - 1);
  }


  Future<String> addSessionToSchedule(int day, Session session) async {
    bool added = _model.getSchedules().elementAt(day - 1).getSessions().add(session);
    if(added) {
      await DatabaseMapper.addSessionToSchedule(DatabaseController().getDatabase(), day, session.key);
      return "Session added to schedule";
    }
    else
      return "Session already added to schedule";
  }


  Future<String> removeSessionFromSchedule(int day, Session session) async {
    _model.getSchedules().elementAt(day - 1).getSessions().remove(session);
    await DatabaseMapper.removeSessionFromSchedule(DatabaseController().getDatabase(), day, session.key);
    return "Session deleted from schedule";
  }


  String getTextActivities(int day) {
    int numActivities = _model.getSchedules().elementAt(day - 1).getSessions().length;
    return numActivities.toString() + " " + (numActivities == 1 ? "activity" : "activities");
  }

  // ----------------------------
  // database methods
  // ----------------------------

  Future initDatabase() async {
//    bool exists = await DatabaseController().createDatabase();
//    if(!exists) {
//      // TODO: usar funcoes para passar a informacao do JSON para a base de dados
//    }
//    else {
//      _model.setScheduleSessions(await getDaySessions(Dates.date1.toDateString()),
//                                 await getDaySessions(Dates.date2.toDateString()),
//                                 await getDaySessions(Dates.date3.toDateString()),
//                                 await getDaySessions(Dates.date4.toDateString()));
//    }

    // TODO: construir map em BluetoothController com ids e localizacoes, por ordem alfabetica
  }


  // TODO: ter metodos que chamam os do DatabaseMapper para retornar coisas para as Views
  Future<SplayTreeSet<Session>> getDaySessions(String dateString) async {
    return await DatabaseMapper.getDaySessions(DatabaseController().getDatabase(), dateString);
  }

  Future<List<Person>> getPeopleWithKeys(List<String> peopleKeys) async {
    return await DatabaseMapper.getPeopleWithKeys(DatabaseController().getDatabase(), peopleKeys);
  }

  Future<List<Item>> getItemsWithKeys(List<String> itemKeys) async {
    return DatabaseMapper.getItemWithKeys(DatabaseController().getDatabase(), itemKeys);
  }


  // ----------------------------
  // json methods
  // ----------------------------

  void updateURLPath(String url) {
    _model.setJsonURL(url);
  }

  Future extractJson() async {
    await JsonController().parseJsonFromURL(_model.getJsonURL());
  }

//  Future<SplayTreeSet<Session>> getDaySessions(String dateString) async {
//    return JsonMapper.sessionSet(await JsonController().getJson(_model.getJsonURL()), dateString);
//  }

//  Future<List<Person>> getPeopleWithKeys(List<String> chairs) async {
//    return JsonMapper.peopleWithKeys(await JsonController().getJson(_model.getJsonURL()), chairs);
//  }

//  Future<List<Item>> getItemsWithKeys(List<String> items) async {
//    return JsonMapper.itemWithKeys(await JsonController().getJson(_model.getJsonURL()), items);
//  }

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