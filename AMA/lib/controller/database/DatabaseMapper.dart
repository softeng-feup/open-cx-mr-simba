import 'dart:collection';
import 'dart:io';
import 'package:ama/model/Item.dart';
import 'package:ama/model/Person.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:ama/model/Session.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseController {
  // TODO: fazer metodos que extraiam informacao da base de dados e converta para classes, para mostrar na View
  static DatabaseController _instance;
  var db;

  static DatabaseController instance() {
    if (_instance == null) _instance = new DatabaseController();
      return _instance;
  }

  createDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "AMADatabase.db");

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "example.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);

    }

    //open the database
    db = await openDatabase(path);
    return db;
  }

  // exemplo:
  static Future<SplayTreeSet<Session>> sessionSet(Database db, String date) async {

  }

  Future<Person> getPerson(String key) async {
    var results = await db.rawQuery('SELECT * FROM Person WHERE personKey = $key');
    if (results.length > 0) {
      return new Person.fromMap(results.first);
    }

    return null;
  }

  Future<Item> getItem(String key) async {
    var results = await db.rawQuery('SELECT * FROM Item WHERE itemKey = $key');
    if (results.length > 0) {
      return new Item.fromMap(results.first);
    }

    return null;
  }
  Future<Session> getSession(String key) async {
    var results = await db.rawQuery('SELECT * FROM Session WHERE sessionKey = $key');
    if (results.length > 0) {
      return new Session.fromMap(results.first);
    }

    return null;
  }

  Future<Schedule> getSchedule(String key) async {
    var results = await db.rawQuery('SELECT * FROM Schedule WHERE scheduleDay = $key');
    if (results.length > 0) {
      return new Schedule.fromMap(results.first);
    }

    return null;
  }

  Future<Session> getScheduleSession(String key) async {
    var results = await db.rawQuery('SELECT * FROM ScheduleSession WHERE sessionKey = $key');
    if (results.length > 0) {
      return new Session.fromMap(results.first);
    }

    return null;
  }

  Future<Item> getSessionItem(String key) async {
    var results = await db.rawQuery('SELECT * FROM SessionItem WHERE sessionKey = $key');
    if (results.length > 0) {
      return new Item.fromMap(results.first);
    }

    return null;
  }

  Future<Person> getSessionChair(String key) async {
    var results = await db.rawQuery('SELECT * FROM SessionChair WHERE sessionKey = $key');
    if (results.length > 0) {
      return new Person.fromMap(results.first);
    }

    return null;
  }

  Future<Person> getItemAuthor(String key) async {
    var results = await db.rawQuery('SELECT * FROM ItemAuthor WHERE itemKey = $key');
    if (results.length > 0) {
      return new Person.fromMap(results.first);
    }

    return null;
  }
}