import 'dart:collection';
import 'package:ama/constants/Utility.dart' as Utility;
import 'package:ama/controller/bluetooth/BluetoothController.dart';
import 'package:ama/controller/database/DatabaseMapper.dart';
import 'package:ama/controller/database/DatabaseController.dart';
import 'package:ama/controller/json/JsonMapper.dart';
import 'package:ama/controller/notifs/NotifsController.dart';
import 'package:ama/model/DayScheduleInfo.dart';
import 'package:ama/model/Item.dart';
import 'package:ama/model/Model.dart';
import 'package:ama/model/Person.dart' as Person;
import 'package:ama/model/Session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'json/JsonController.dart';

class Controller {
  static Controller _instance;
  Model _model;

  Controller() {
    _model = new Model();
  }

  static Controller instance() {
    if (_instance == null) _instance = new Controller();

    return _instance;
  }

  // -----------------------------------------
  // regular controller (and database) methods
  // -----------------------------------------

  DayScheduleInfo getDaySchedule(int day) {
    return _model.getSchedules().elementAt(day - 1);
  }

  Future<String> addSessionToSchedule(Session session) async {
    int day = await DatabaseMapper.getScheduleDayFromDate(DatabaseController().getDatabase(), session.day);
    
    bool added = _model.getSchedules().elementAt(day - 1).getSessions().add(session);
    if(added) {
      await DatabaseMapper.addSessionToSchedule(DatabaseController().getDatabase(), day, session.key);
      await NotifsController.instance().scheduleNotificationForSession(session);
      return "Session added to schedule";
    } else
      return "Session already added to schedule";
  }

  Future<String> removeSessionFromSchedule(int day, Session session) async {
    _model.getSchedules().elementAt(day - 1).getSessions().remove(session);
    await DatabaseMapper.removeSessionFromSchedule(DatabaseController().getDatabase(), day, session.key);
    await NotifsController.instance().removeNotificationForSession(session);
    return "Session deleted from schedule";
  }

  String getTextActivities(int day) {
    int numActivities =
        _model.getSchedules().elementAt(day - 1).getSessions().length;
    return numActivities.toString() +
        " " +
        (numActivities == 1 ? "activity" : "activities");
  }

  // ----------------------------
  // database methods
  // ----------------------------

  Future<bool> initDatabase() async {
    bool exists = await DatabaseController().checkIfDatabaseExists();

    if (!exists) {
      Map<String, dynamic> json =
          await JsonController().parseJsonFromURL(_model.getJsonURL());
      if (json == null) return false;

      await DatabaseController().createDatabase();

      // passes information from JSON to database
      await DatabaseController().fillDatabasePerson(JsonMapper.getPeople(json));
      await DatabaseController().fillDatabaseItem(JsonMapper.getItems(json));
      await DatabaseController().fillDatabaseSession(JsonMapper.getSessions(json));

    } else {

      await DatabaseController().createDatabase();

      _model.setScheduleSessions(
          await DatabaseMapper.getScheduleInfo(
              DatabaseController().getDatabase(), 1),
          await DatabaseMapper.getScheduleInfo(
              DatabaseController().getDatabase(), 2),
          await DatabaseMapper.getScheduleInfo(
              DatabaseController().getDatabase(), 3),
          await DatabaseMapper.getScheduleInfo(
              DatabaseController().getDatabase(), 4));
    }

    BluetoothController.instance().fillLocationMap(
        await DatabaseMapper.getLocationsByOrder(
            DatabaseController().getDatabase()));
    return true;
  }

  Future<SplayTreeSet<Session>> getDaySessions(String dateString) async {
    return await DatabaseMapper.getDaySessions(
        DatabaseController().getDatabase(), dateString);
  }

  Future<List<Person.Person>> getPeopleWithKeys(List<String> peopleKeys) async {
    return await DatabaseMapper.getPeopleWithKeys(
        DatabaseController().getDatabase(), peopleKeys);
  }

  Future<List<Item>> getItemsWithKeys(List<String> itemKeys) async {
    return DatabaseMapper.getItemWithKeys(
        DatabaseController().getDatabase(), itemKeys);
  }

  Future<Session> getSessionWithKey(String sessionKey) async {
    return DatabaseMapper.getSession(DatabaseController().getDatabase(), sessionKey);
  }

  Future<List<String>> getLocationsByOrder() async {
    return DatabaseMapper.getLocationsByOrder(DatabaseController().getDatabase());
  }

  Future<int> getLastUsedCustomSessionIDNum() async {
    return DatabaseMapper.getLastUsedCustomSessionIDNum(DatabaseController().getDatabase());
  }

  Future addSession(Session session) async {
    return DatabaseMapper.addSession(DatabaseController().getDatabase(), session);
  }

  Future<SplayTreeSet<Session>> getSessionsByLocation(String location) async {
    return await DatabaseMapper.getSessionsInLocation(DatabaseController().getDatabase(), location);
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

  Future<Set<int>> searchForBeaconLocations() async {
    return BluetoothController.instance().searchForBeacons();
  }

  Future<List<Session>> getSessionsNearby(Set<int> locations) async {
    DateTime currentTime = new DateTime.now();
    List<Session> nearbySessions = List();
    Set<String> locationsStr = Set<String>();

    for (int id in locations) {
      locationsStr.add(BluetoothController.instance().getLocation(id));
    }

    for (String location in locationsStr) {
      SplayTreeSet<Session> sessionsInLocation =
          await DatabaseMapper.getSessionsInLocation(
              DatabaseController().getDatabase(), location);

      sessionsInLocation.forEach((s) {
        DateTime startTime = s.startTime;
        if (startTime.isAfter(currentTime) &&
            ((startTime.difference(currentTime)).inMinutes <=
                Utility.numMinutesForSessionBLE)) {
          nearbySessions.add(s);
        }
      });
    }

    return nearbySessions;
  }


  // ----------------------------
  // notification methods
  // ----------------------------

  void initNotifsController(GlobalKey<NavigatorState> navKey) {
    NotifsController.instance().init(navKey);
  }

  Future<NotificationAppLaunchDetails> getAppLaunchDetails() async {
    return NotifsController.instance().getDetails();
  }

}
