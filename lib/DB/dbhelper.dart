import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final String dbName = 'mydatabase.db';
  static final int dbVersion = 1;
  static final String _tablename = 'mytable';
  static final String colId = 'id';
  static final String colName = 'name';

  // Singleton class setup
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  // Accessor for database instance
  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  // Initialize database
  Future<Database> _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    return await openDatabase(path, version: dbVersion, onCreate: _onCreate);
  }

  // Create table on database creation
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tablename (
        $colId INTEGER PRIMARY KEY,
        $colName TEXT NOT NULL
      )
    ''');
  }

  // Insert function
  Future<int> insertFunction(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(_tablename, row);
  }

  // Query all function
  Future<List<Map<String, dynamic>>> queryAllFunction() async {
    Database? db = await instance.database;
    return await db!.query(_tablename);
  }

  // Update function
  Future<int> updateFunction(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[colId];
    return await db!.update(
      _tablename,
      row,
      where: '$colId = ?',
      whereArgs: [id],
    );
  }

  // Delete function
  Future<int> deleteFunction(int id) async {
    Database? db = await instance.database;
    return await db!.delete(
      _tablename,
      where: '$colId = ?',
      whereArgs: [id],
    );
  }
}

