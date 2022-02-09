class LoginRegisterResponseModel {
  LoginRegisterSuccessResponseModel? success;
  dynamic status;
  dynamic error;
  LoginRegisterResponseModel(
      {required this.status, this.error, required this.success});

  LoginRegisterResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["Status"];
    error = json["Message"];
    if (json['Success'] != null) {
      success = LoginRegisterSuccessResponseModel.fromJson(json['Success']);
    }
  }
}

class LoginRegisterSuccessResponseModel {
  LoginRegisterSuccessResponseModel({
    required this.token,
  });

  String token;

  factory LoginRegisterSuccessResponseModel.fromJson(
          Map<String, dynamic> json) =>
      LoginRegisterSuccessResponseModel(
        token: json['token'],
      );
}
