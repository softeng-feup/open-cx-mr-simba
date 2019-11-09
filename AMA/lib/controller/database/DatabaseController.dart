import 'dart:io';
import 'dart:typed_data';
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

  // creates the database and copies it from the assets if it doesn't exist yet
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



  Future fillPersonTable(Map<String, Person> people) async {
    people.forEach((k, p) {
      _database.insert('Person', p.toMap());
    });
  }
}

