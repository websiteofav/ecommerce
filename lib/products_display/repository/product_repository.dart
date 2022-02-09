import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce/products_display/model/mobile_response_model.dart';
import 'package:ecommerce/utils/apis.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

class ProductsRepository {
 
  final storage = const FlutterSecureStorage();
  Future<MobileResponseModel> getAllMobiles() async {
        final token = await storage.read(key: 'token');
        
    var response = await http
        .get(Uri.parse(API.getAllMobiles), headers: {"Authorization": token ?? ''});
    log(response.body.toString());

    var data = json.decode(response.body);

    MobileResponseModel model = MobileResponseModel.fromJson(data);
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
