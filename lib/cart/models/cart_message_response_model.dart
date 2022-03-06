class CartMessageResponseModel {
  CartMessageResponseModel({required this.success, this.error, this.status});

  late CartResponseSuccessResponseModel success;
  dynamic status;
  dynamic error;
  CartMessageResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["Status"];
    error = json["Message"];
    if (json['Success'] != null) {
      // success = List<CartResponseSuccessResponseModel>.from(json["Success"]
      //     .map((x) => CartResponseSuccessResponseModel.fromJson(x)));
      success = CartResponseSuccessResponseModel.fromJson(json['Success']);
    }
  }
}

class CartResponseSuccessResponseModel {
  CartResponseSuccessResponseModel({
    required this.message,
  });

  dynamic message;

  factory CartResponseSuccessResponseModel.fromJson(
          Map<String, dynamic> json) =>
      CartResponseSuccessResponseModel(message: json["message"]);
}
