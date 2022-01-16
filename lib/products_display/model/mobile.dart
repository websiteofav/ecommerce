import 'dart:convert';

class MobileResponse {
  MobileResponse({
    required this.success,
  });

  dynamic success;

  factory MobileResponse.fromJson(List<Map<String, dynamic>> json) =>
      MobileResponse(
        success: json.isNotEmpty
            ? List<MobileSuccess>.from(
                json.map(
                  (x) => MobileSuccess.fromJson(x),
                ),
              )
            : null,
      );

  Map<String, dynamic> toJson() => {
        "Success": List<dynamic>.from(success.map((x) => x.toJson())),
      };
}

class MobileSuccess {
  MobileSuccess(
      {required this.id,
      required this.name,
      required this.image,
      required this.offerPrice,
      required this.discount,
      required this.size,
      required this.battery,
      required this.storage,
      required this.operatingSystem,
      required this.networkType,
      required this.camera1,
      required this.camera2,
      required this.hybridSim,
      required this.clock,
      required this.realPrice});

  dynamic id;
  dynamic name;
  dynamic image;
  dynamic offerPrice;
  dynamic discount;
  dynamic size;

  dynamic battery;
  dynamic storage;
  dynamic operatingSystem;
  dynamic networkType;
  dynamic camera1;
  dynamic camera2;
  dynamic hybridSim;
  dynamic clock;

  dynamic realPrice;

  factory MobileSuccess.fromJson(Map<String, dynamic> json) => MobileSuccess(
      id: json["id"],
      name: json["name"],
      image: json["image"],
      offerPrice: json["offerPrice"],
      discount: json["discount"],
      size: json["size"],
      battery: json["battery"],
      storage: json["storage"],
      operatingSystem: json["operatingSystem"],
      networkType: json["networkType"],
      camera1: json["camera1"],
      camera2: json["camera2"],
      hybridSim: json["hybridSim"],
      clock: json["clock"],
      realPrice: json["realPrice"]);
// QueryRow ({id: 2, name: Redni1, image: assets/images/electronic/mobiles/mobile2.jpg, realPrice: 32000, offerPrice: 25222, discount: 13, size: 6, battery: 5500, storage: 128, operatingSystem: Android 12, networkType: 5G, camera1: 64, camera2: 6, hybridSim: Yes, clock: 2.5})
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "offerPrice": offerPrice,
        "discount": discount,
        "size": size,
        "battery": battery,
        "storage": storage,
        "operatingSystem": operatingSystem,
        "networkType": networkType,
        "camera1": camera1,
        "camera2": camera2,
        "hybridSim": hybridSim,
        "clock": clock,
        "realPrice": realPrice
      };
}


// id TEXT PRIMARY KEY, name TEXT, image STRING, realPrice STRING, offerPrice STRING, discount STRING, size STRING, battery STRING, storage STRING, operatingSystem STRING, networkType STRING, camera1 STRING, camera2 STRING, hybridSim STRING, clock STRING