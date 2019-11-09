import 'dart:collection';
import 'package:ama/model/Item.dart';
import 'package:ama/model/Person.dart';
import 'package:ama/model/Schedule.dart';
import 'package:ama/model/Session.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseMapper {
  // TODO: fazer metodos que extraiam informacao da base de dados e converta para classes, para mostrar na View

  static Future<SplayTreeSet<Session>> sessionSet(Database db, String date) async {

  }

  Future<Person> getPerson(Database db, String key) async {
    var results = await db.rawQuery('SELECT * FROM Person WHERE personKey = $key');
    if (results.length > 0) {
      return new Person.fromMap(results.first);
    }

    return null;
  }

  Future<Item> getItem(Database db, String key) async {
    var results = await db.rawQuery('SELECT * FROM Item WHERE itemKey = $key');
    if (results.length > 0) {
      return new Item.fromMap(results.first);
    }

    return null;
  }
  Future<Session> getSession(Database db, String key) async {
    var results = await db.rawQuery('SELECT * FROM Session WHERE sessionKey = $key');
    if (results.length > 0) {
      return new Session.fromMap(results.first);
    }

    return null;
  }

  Future<Schedule> getSchedule(Database db, String key) async {
    var results = await db.rawQuery('SELECT * FROM Schedule WHERE scheduleDay = $key');
    if (results.length > 0) {
      return new Schedule.fromMap(results.first);
    }

    return null;
  }

  Future<Session> getScheduleSession(Database db, String key) async {
    var results = await db.rawQuery('SELECT * FROM ScheduleSession WHERE sessionKey = $key');
    if (results.length > 0) {
      return new Session.fromMap(results.first);
    }

    return null;
  }

  Future<Item> getSessionItem(Database db, String key) async {
    var results = await db.rawQuery('SELECT * FROM SessionItem WHERE sessionKey = $key');
    if (results.length > 0) {
      return new Item.fromMap(results.first);
    }

    return null;
  }

  Future<Person> getSessionChair(Database db, String key) async {
    var results = await db.rawQuery('SELECT * FROM SessionChair WHERE sessionKey = $key');
    if (results.length > 0) {
      return new Person.fromMap(results.first);
    }

    return null;
  }

  Future<Person> getItemAuthor(Database db, String key) async {
    var results = await db.rawQuery('SELECT * FROM ItemAuthor WHERE itemKey = $key');
    if (results.length > 0) {
      return new Person.fromMap(results.first);
    }

    return null;
  }
}