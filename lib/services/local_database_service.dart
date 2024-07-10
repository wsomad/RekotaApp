import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseService {
  static final LocalDatabaseService _instance = LocalDatabaseService._instance;
  static Database? _database;

  factory LocalDatabaseService() {
    return _instance;
  }

  LocalDatabaseService._internal();

  Future<Database> _getDatabase() async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'task_management_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            uid TEXT PRIMARY KEY,
            fullname TEXT,
            email TEXT,
            password TEXT,
            role TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE tasks (
            taskID TEXT PRIMARY KEY;
            title TEXT;
            description TEXT;
            dateCreated INTEGER;
            dueDate INTEGER;
            priority TEXT;
            isCompleted INTEGER;
          )
        ''');
        await db.execute('''
          CREATE TABLE categories (
            categoryID TEXT PRIMARY KEY;
            name TEXT;
            color TEXT;
            icon TEXT;
          )
        ''');
        await db.execute('''
          CREATE TABLE reminders (
            reminderID TEXT PRIMARY KEY;
            dateTime INTEGER;
            taskId TEXT;
          )
        ''');
        await db.execute('''
          CREATE TABLE notes (
            noteID TEXT PRIMARY KEY;
            content TEXT;
            createdAt INTEGER;
            taskId TEXT;
          )
        ''');
      },
    );
  }

  Future<void> insert(String table, Map<String, dynamic> data) async {
    try {
      final db = await _getDatabase();
      await db.insert(table, data);
    } catch (e) {
      print("Error inserting into $table: $e");
      throw Exception("Database insert error.");
    }
  }

  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    try {
      final db = await _getDatabase();
      return await db.query(table);
    } catch (e) {
      print("Error querying $table: $e");
      throw Exception("Database query error");
    }
  }

  Future<Map<String, dynamic>?> queryById(String table, String id) async {
    try {
      final db = await _getDatabase();
      final List<Map<String, dynamic>> results = await db.query(
        table,
        where: 'id = ?',
        whereArgs: [id],
      );
      if (results.isNotEmpty) {
        return results.first;
      }
      else {
        return null;
      }
    } catch (e) {
      print("Error querying $id from $table: $e");
      throw Exception("Database query error");
    }
  }

  Future<void> update(String table, String id, Map<String, dynamic> data) async {
    try {
      final db = await _getDatabase();
      await db.update(table, data, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print("Error updating $table: $e");
      throw Exception("Database update error");
    }
  }

  Future<void> delete(String table, String id) async {
    try {
      final db = await _getDatabase();
      await db.delete(table, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print("Error deleting from $table: $e");
      throw Exception("Database delete error");
    }
  }
}
