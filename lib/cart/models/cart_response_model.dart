class CartResponseModel {
  CartResponseModel({required this.success, this.error, this.status});

  late List<CartSuccessResponseModel> success;
  dynamic status;
  dynamic error;
  CartResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["Status"];
    error = json["Message"];
    if (json['Success'] != null) {
      success = List<CartSuccessResponseModel>.from(
          json["Success"].map((x) => CartSuccessResponseModel.fromJson(x)));
    }
  }
}

class CartSuccessResponseModel {
  CartSuccessResponseModel({
    required this.name,
    required this.image,
    required this.price,
    required this.discount,
    required this.quantity,
    required this.id,
    required this.realPrice,
  });

  dynamic name, quantity, price, realPrice, discount, image, id;

  factory CartSuccessResponseModel.fromJson(Map<String, dynamic> json) =>
      CartSuccessResponseModel(
          name: json["name"],
          discount: json["discount"],
          price: json["price"],
          quantity: json["quantity"],
          realPrice: json["realprice"],
          image: json["image"],
          id: json["_id"]);
// QueryRow ({id: 2, name: Redni1, image: assets/images/electronic/mobiles/mobile2.jpg, realPrice: 32000, offerPrice: 25222, discount: 13, size: 6, battery: 5500, storage: 128, operatingSystem: Android 12, networkType: 5G, camera1: 64, camera2: 6, hybridSim: Yes, clock: 2.5})
}
