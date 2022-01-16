import 'package:sqflite/sqflite.dart' as sql;

import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> getDatabase(table) async {
    final dbPath = await sql.getDatabasesPath();
    if (table == 'mobiles') {
      return await sql.openDatabase(path.join(dbPath, '$table.db'),
          onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE mobiles(id TEXT PRIMARY KEY, name TEXT, image STRING, realPrice STRING, offerPrice STRING, discount STRING, size STRING, battery STRING, storage STRING, operatingSystem STRING, networkType STRING, camera1 STRING, camera2 STRING, hybridSim STRING, clock STRING)',
        );
      }, version: 1);
    } else {
      return await sql.openDatabase(path.join(dbPath, '$table.db'),
          onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE mobiles(id TEXT PRIMARY KEY, name TEXT, image STRING, realPrice STRING, offerPrice STRING, discount STRING, size STRING, battery STRING, storage STRING, operatingSystem STRING, networkType STRING, camera1 STRING, camera2 STRING, hybridSim STRING, clock STRING)',
        );
      });
    }
  }

  static Future<void> insertMobile(
      String table, Map<String, Object> data) async {
    final db = await DBHelper.getDatabase(table);
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.getDatabase(table);
    return db.query(table);
  }

  static Future<int> deleteData(String table, String id) async {
    final db = await DBHelper.getDatabase(table);
    return db.rawDelete('DELETE FROM $table WHERE id = $id');
  }
}
