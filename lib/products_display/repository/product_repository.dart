import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce/products_display/models/mobile_response_model.dart';
import 'package:ecommerce/utils/apis.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class ProductsRepository {
  final storage = const FlutterSecureStorage();
  Future<MobileResponseModel> getAllMobiles() async {
    final token = await storage.read(key: 'token');

    var response = await http.get(Uri.parse(API.getAllMobiles),
        headers: {"Authorization": token ?? ''});
    log(response.body.toString());

    var data = json.decode(response.body);

    MobileResponseModel model = MobileResponseModel.fromJson(data);
    return model;
  }
}
