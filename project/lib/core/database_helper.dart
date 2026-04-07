// lib/core/database_helper.dart
import 'dart:developer' as Developer;

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }
  

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    Developer.log('Database path: $dbPath');
    final path = join(dbPath, 'app_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, date DATETIME, value TEXT)');
      },
    );
  }
}