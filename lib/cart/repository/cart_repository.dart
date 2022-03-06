import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce/cart/models/cart_message_response_model.dart';
import 'package:ecommerce/cart/models/cart_response_model.dart';
import 'package:ecommerce/utils/apis.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class CartRepository {
  final storage = const FlutterSecureStorage();
  Future<CartResponseModel> getCart() async {
    final token = await storage.read(key: 'token');

    var response = await http.get(Uri.parse(API.getCart), headers: {
      "Authorization": token ?? '',
    });
    log(response.body.toString());

    var data = json.decode(response.body);

    CartResponseModel model = CartResponseModel.fromJson(data);
    return model;
  }

// {"Success":{"_id":"6204d1269c150f5efe629f18","user":"61e6de24f7c93f4065c181e0","products":[{"name":"Halo 1","price":"40000","realprice":"50000","discount":"22","quantity":"1","image":"mobile5","_id":"6204d1569c150f5efe629f1f"},{"name":"Applace","price":"40000","realprice":"50000","discount":"22","quantity":"3","image":"mobile3","_id":"6204d1269c150f5efe629f19"}],"__v":1},"Status":200,"Message":null}
  Future<CartResponseModel> addItemToCart({jsonPostdata}) async {
    final token = await storage.read(key: 'token');

    log(jsonPostdata.toString());

    var response = await http.post(
      Uri.parse(API.getCart),
      headers: {
        "Authorization": token ?? '',
        "Content-Type": "application/json"
      },
      body: json.encode(jsonPostdata),
    );
    log(response.body.toString());

    var data = json.decode(response.body);

    CartResponseModel model = CartResponseModel.fromJson(data);
    return model;
  }

  Future<CartResponseModel> changeQuantityOfItemFromCart(
      {id, jsonPostdata}) async {
    final token = await storage.read(key: 'token');

    var response = await http.put(
      Uri.parse('${API.getCart}/$id'),
      body: jsonPostdata,
      headers: {"Authorization": token ?? ''},
    );
    log(response.body.toString());

    var data = json.decode(response.body);

    CartResponseModel model = CartResponseModel.fromJson(data);

    return model;
  }

  Future<CartResponseModel> removeItemFromCart({id}) async {
    final token = await storage.read(key: 'token');

    var response = await http.delete(
      Uri.parse('${API.getCart}/$id'),
      headers: {"Authorization": token ?? ''},
    );
    log(response.body.toString());

    var data = json.decode(response.body);

    CartResponseModel model = CartResponseModel.fromJson(data);

    return model;
  }
}
