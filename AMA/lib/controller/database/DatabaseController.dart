import 'dart:io';
import 'dart:typed_data';
import 'package:ama/model/Item.dart';
import 'package:ama/model/Session.dart';
import 'package:path/path.dart';

import 'package:ama/model/Person.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ama/constants/Utility.dart' as Utility;

class DatabaseController {
  static final DatabaseController _controller = DatabaseController._internal();
  Database _database;
 
  factory DatabaseController() {
    return _controller;
  }

  DatabaseController._internal();

  Database getDatabase() {
    return _database;
  }

  Future<bool> createDatabase() async {
    var path = join(await getDatabasesPath(), Utility.databaseName);

    // Check if the database exists
    var exists = await databaseExists(path);

    // Should happen only the first time you launch your application
    if (!exists) {
   
      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
        
      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", Utility.databaseName));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      
      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    }

    // open the database
    _database = await openDatabase(path);

    return exists;
  }


  Future fillDatabasePerson(List<Person> people) async {
    for (Person person in people) {
      await _database.insert('Person', person.toMap());
    }
  }


  Future fillDatabaseItem(List<Item> items) async {
    for (Item item in items) {
      List<Map<String, dynamic>> mapList = item.toMap();
     
      await _database.insert('Item', mapList[0]);

      for (var i = 1; i < mapList.length; i++) {
        await _database.insert('ItemAuthor', mapList[i]);
      }
    }
  }


  Future fillDatabaseSession(List<Session> sessions) async {
    for (Session session in sessions) {
      await _database.insert('Session', session.toMapSession());
      
      List<Map<String, dynamic>> sessionChairs = session.toMapChairs();
      
      for (Map<String, dynamic> map in sessionChairs) {
        await _database.insert('SessionChair', map);
      }

      List<Map<String, dynamic>> sessionItems = session.toMapItems();
      
      for (Map<String, dynamic> map in sessionItems) {
        await _database.insert('SessionItem', map);
      }
    }
  }

}

