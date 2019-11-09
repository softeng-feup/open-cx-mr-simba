import 'dart:collection';
import 'package:ama/model/DayScheduleInfo.dart';
import 'package:ama/model/Item.dart';
import 'package:ama/model/Person.dart';
import 'package:ama/model/Session.dart';
import 'package:sqflite/sqflite.dart';
import '../../constants/Dates.dart';

class DatabaseMapper {

  static Future<SplayTreeSet<Session>> getDaySessions(Database db, String date) async {
    var results = await db.rawQuery('SELECT * FROM Session NATURAL JOIN SessionItem NATURAL JOIN SessionChair WHERE day = ?', [date]);
    SplayTreeSet<Session> sessions = SplayTreeSet();
    if(results.length > 0) {
      String currentSessionKey = results.elementAt(0)['sessionKey'];
      List<Map<String, dynamic>> sessionValues = [results.elementAt(0)];
      for (int i = 1; i < results.length; i++) {
        if(currentSessionKey != results.elementAt(i)['sessionKey']) { // if new session is considered
          sessions.add(Session.fromMap(sessionValues));
          sessionValues = [results.elementAt(i)];
        }
        else {
          sessionValues.add(results.elementAt(i));
        }
      }
      sessions.add(Session.fromMap(sessionValues)); // add last session
    }
    return sessions;
  }


  static Future<List<Person>> getPeopleWithKeys(Database db, List<String> keys) async {
    List<Person> people = [];
    for(int i = 0; i < keys.length; i++) {
      var results = await db.rawQuery(
          'SELECT * FROM Person WHERE personKey = ?', [keys.elementAt(i)]);
      if (results.length > 0) {
        people.add(new Person.fromMap(results.first));
      }
    }
    return people;
  }


  static Future<List<Item>> getItemWithKeys(Database db, List<String> keys) async {
    List<Item> items = [];
    for(int i = 0; i < keys.length; i++) {
      var results = await db.rawQuery(
          'SELECT * FROM Item NATURAL JOIN ItemAuthor WHERE itemKey = ?',
          [keys.elementAt(i)]);
      if (results.length > 0) {
         items.add(new Item.fromMap(results));
      }
    }
    return items;
  }


  static Future<Session> getSession(Database db, String key) async {
    var results = await db.rawQuery('SELECT * FROM Session NATURAL JOIN SessionItem NATURAL JOIN SessionChair WHERE sessionKey = ?', [key]);
    if (results.length > 0) {
      return new Session.fromMap(results);
    }
    return null;
  }


  static Future<DayScheduleInfo> getScheduleInfo(Database db, int day) async {
    var results = await db.rawQuery('SELECT * FROM Schedule NATURAL JOIN ScheduleSession WHERE scheduleDay = ?', [day]);
    SplayTreeSet sessions = SplayTreeSet();
    for(int i = 0; i < results.length; i++) {
      sessions.add(await getSession(db, results.elementAt(i)['sessionKey']));
    }
    return DayScheduleInfo.withSessions(results.elementAt(0)['scheduleDay'], Date.fromDate(results.elementAt(0)['weekday'], results.elementAt(0)['date']) ,sessions);
  }


  static Future removeSessionFromSchedule(Database db, int day, String sessionKey) async {
    await db.rawDelete('DELETE FROM ScheduleSession WHERE sessionKey = ? AND scheduleDay = ?', [sessionKey, day]);
  }


  static Future addSessionToSchedule(Database db, int day, String sessionKey) async {
    await db.rawInsert('INSERT INTO ScheduleSession(sessionKey, scheduleDay) VALUES (?, ?)', [sessionKey, day]);
  }


  // em principio nao vamos precisar destes

//  Future<Session> getScheduleSession(Database db, String key) async {
//    var results = await db.rawQuery('SELECT * FROM ScheduleSession WHERE sessionKey = ?', [key]);
//    if (results.length > 0) {
//      return new Session.fromMap(results.first);
//    }
//
//    return null;
//  }
//
//
//  Future<Item> getSessionItem(Database db, String key) async {
//    var results = await db.rawQuery('SELECT * FROM SessionItem WHERE sessionKey = ?', [key]);
//    if (results.length > 0) {
//      return new Item.fromMap(results.first);
//    }
//    return null;
//  }
//
//
//  Future<Person> getSessionChair(Database db, String key) async {
//    var results = await db.rawQuery('SELECT * FROM SessionChair WHERE sessionKey = ?', [key]);
//    if (results.length > 0) {
//      return new Person.fromMap(results.first);
//    }
//    return null;
//  }
//
//
//  Future<Person> getItemAuthor(Database db, String key) async {
//    var results = await db.rawQuery('SELECT * FROM ItemAuthor WHERE itemKey = ?', [key]);
//    if (results.length > 0) {
//      return new Person.fromMap(results.first);
//    }
//    return null;
//  }
}