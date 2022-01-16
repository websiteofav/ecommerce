import 'dart:convert';

import 'package:ecommerce/products_display/model/mobile.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class ProductsRepository {
  Future<MobileResponse> getData({required table}) async {
    final db = await getDatabase(table: table);
    var data = await db.query(table);

    // data = json.decode(data.toString());

    MobileResponse model = MobileResponse.fromJson(data);

    return model;
  }

  Future<sql.Database> getDatabase({required table}) async {
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
}
