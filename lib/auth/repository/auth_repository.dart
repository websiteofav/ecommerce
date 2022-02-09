import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce/utils/apis.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:ecommerce/auth/models/auth_response_model.dart';
import 'package:ecommerce/auth/models/login_register_response_model.dart';

class AuthRepository {
  final storage = const FlutterSecureStorage();
  Future<AuthResponseModel> authUser({jsonPostdata}) async {
    final token = await storage.read(key: 'token');

    log(jsonPostdata.toString());
    var response = await http
        .get(Uri.parse(API.auth), headers: {"Authorization": token ?? ''});
    log(response.body.toString());

    var data = json.decode(response.body);

    AuthResponseModel model = AuthResponseModel.fromJson(data);
    return model;
  }

  Future<LoginRegisterResponseModel> login({required jsonPostdata}) async {
    log(jsonPostdata.toString());
    var response = await http.post(
      Uri.parse(API.login),
      body: json.encode(jsonPostdata),
      headers: {"Content-Type": "application/json"},
    );

    log(response.body.toString());

    var data = json.decode(response.body);
    LoginRegisterResponseModel model =
        LoginRegisterResponseModel.fromJson(data);

    if (model.success != null) {
      await storage.write(key: 'token', value: model.success!.token);
    }
    return model;
  }

  Future<LoginRegisterResponseModel> register(
      {timeStamp, jsonPostdata, checkSum}) async {
    log(jsonPostdata.toString());
    var response = await http.post(
      Uri.parse(API.register),
      body: json.encode(jsonPostdata),
      headers: {"Content-Type": "application/json"},
    );
    log(response.body.toString());

    var data = json.decode(response.body);
    LoginRegisterResponseModel model =
        LoginRegisterResponseModel.fromJson(data);

    if (model.success != null) {
      await storage.write(key: 'token', value: model.success!.token);
    }
    return model;
  }

  Future<void> logout({timeStamp, jsonPostdata, checkSum}) async {
    await storage.delete(key: 'token');
  }
}
