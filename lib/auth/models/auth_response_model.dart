class AuthResponseModel {
  late AuthSuccessResponseModel success;
  dynamic status;
  dynamic error;
  AuthResponseModel({required this.status, this.error, required this.success});

  AuthResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["Status"];
    error = json["Message"];
    if (json['Success'] != null) {
      success = AuthSuccessResponseModel.fromJson(json['Success']);
    }
  }
}

class AuthSuccessResponseModel {
  AuthSuccessResponseModel({
    required this.email,
    required this.password,
    required this.name,
    required this.mobileNumber,
  });

  dynamic email;
  dynamic password;
  dynamic name;
  dynamic mobileNumber;

  factory AuthSuccessResponseModel.fromJson(Map<dynamic, dynamic> json) =>
      AuthSuccessResponseModel(
        email: json['email'],
        password: json['password'],
        name: json['name'],
        mobileNumber: json['mobileNumber'],
      );
}
