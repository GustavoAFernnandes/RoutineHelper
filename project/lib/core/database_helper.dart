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
        await _onCreate(db, version);
      },
    );
    
  }
  Future<void> _onCreate(Database db, int version) async {
  // 1. Criamos a tabela "Pai" (Mes)
  await db.execute('''
    CREATE TABLE meses (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome_mes TEXT,
      ano TEXT
    )
  ''');

  // 2. Criamos a tabela "Filho" (Dia)
  await db.execute('''
    CREATE TABLE dias (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date TEXT,
      value REAL,
      mes_id INTEGER, 
      FOREIGN KEY (mes_id) REFERENCES meses (id) ON DELETE CASCADE
    )
  ''');
  // 3. Inserir os meses de 1 a 12 para o ano 2026
  final String anoAlvo = "2026";
  const List<String> meses = [
  'Janeiro',
  'Fevereiro',
  'Março',
  'Abril',
  'Maio',
  'Junho',
  'Julho',
  'Agosto',
  'Setembro',
  'Outubro',
  'Novembro',
  'Dezembro',
];
  for (int i = 1; i <= 12; i++) {
    await db.insert('meses', {
      'id': i,
      'nome_mes': meses[i - 1],
      'ano': anoAlvo,
    });
  }
  
  print("Banco criado e meses de 1 a 12 de $anoAlvo inseridos com sucesso!");
}
}