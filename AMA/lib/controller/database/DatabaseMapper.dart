import 'dart:collection';
import 'package:path/path.dart';
import 'package:ama/model/Session.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseController {
  // TODO: fazer metodos que extraiam informacao da base de dados e converta para classes, para mostrar na View
  static DatabaseController _instance;

  static DatabaseController instance() {
    if (_instance == null) _instance = new DatabaseController();
      return _instance;
  }

  createDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'AMADatabase.db');

    var database = await openDatabase(dbPath, version: 1);
    return database;
  }

  // exemplo:
  static Future<SplayTreeSet<Session>> sessionSet(Database db, String date) async {

  }
}