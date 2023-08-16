// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;
// import 'package:sqflite/sql.dart';

class SQLHelper {
  static const _dbName = 'items_database.db';
  static const _tableName = 'items';

  static Future<void> createTable(sql.Database database) async {
    await database.execute("""
      CREATE TABLE items(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      title TEXT, 
      description TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      join(
        await sql.getDatabasesPath(),
        _dbName,
      ),
      version: 1,
      onCreate: (sql.Database db, version) async {
        await createTable(db);
      },
    );
  }

  static Future<int> addItem(
    String title,
    String? description,
  ) async {
    final db = await SQLHelper.db();

    final data = {'title': title, 'description': description};
    final id = db.insert(
      _tableName,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllItems() async {
    final db = await SQLHelper.db();

    return db.query(_tableName, orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();

    return db.query(_tableName, where: 'id = ?', whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(
    int id,
    String title,
    String? description,
  ) async {
    final db = await SQLHelper.db();
    final data = {
      'title': title,
      'description': description,
      'createdAt': DateTime.now().toString()
    };
    return db.update(_tableName, data, where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();

    try {
      await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
    } catch (error) {
      debugPrint("Cannot Delete The Item: $error");
    }
  }
}
