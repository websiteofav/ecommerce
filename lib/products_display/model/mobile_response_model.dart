class MobileResponseModel {
  MobileResponseModel({required this.success, this.error, this.status});

  late List<MobileSuccessResponseModel> success;
  dynamic status;
  dynamic error;
  MobileResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["Status"];
    error = json["Message"];
    if (json['Success'] != null) {
      success = List<MobileSuccessResponseModel>.from(
          json["Success"].map((x) => MobileSuccessResponseModel.fromJson(x)));
    }
  }
}

class MobileSuccessResponseModel {
  MobileSuccessResponseModel(
      {required this.name,
      required this.image,
      required this.price,
      required this.discount,
      required this.displaySize,
      required this.batteryCapicity,
      required this.internalStorage,
      required this.operatingSystem,
      required this.networkType,
      required this.camera1,
      required this.camera2,
      required this.simType,
      required this.clockSpeed,
      required this.realPrice,
      required this.camera3,
      required this.camera4,
      required this.category,
      required this.colors,
      required this.hybridSimSlot,
      required this.modelNumber,
      required this.processorType,
      required this.quantity,
      required this.ram,
      required this.subcategory,
      required this.id});

  dynamic name,
      simType,
      modelNumber,
      category,
      subcategory,
      image,
      displaySize,
      operatingSystem,
      processorType,
      clockSpeed,
      internalStorage,
      ram,
      networkType,
      batteryCapicity,
      camera1,
      camera2,
      camera3,
      camera4,
      hybridSimSlot,
      quantity,
      colors,
      price,
      realPrice,
      discount,
      id;

  factory MobileSuccessResponseModel.fromJson(Map<String, dynamic> json) =>
      MobileSuccessResponseModel(
          name: json["name"],
          simType: json["simtype"],
          image: json["image"],
          modelNumber: json["modelnumber"],
          discount: json["discount"],
          category: json["category"],
          subcategory: json["subcategory"],
          displaySize: json["displaysize"],
          operatingSystem: json["operatingsystem"],
          networkType: json["networktype"],
          camera1: json["camera1"],
          camera2: json["camera2"],
          processorType: json["processortype"],
          clockSpeed: json["clockspeed"],
          internalStorage: json["internalstorage"],
          ram: json["ram"],
          batteryCapicity: json["batteryCapicity"],
          camera3: json["camera3"],
          camera4: json["camera4"],
          colors: json['colors'],
          hybridSimSlot: json["hybridsimslot"],
          price: json["price"],
          quantity: json["quantity"],
          realPrice: json["realprice"],
          id: json["_id"]);
// QueryRow ({id: 2, name: Redni1, image: assets/images/electronic/mobiles/mobile2.jpg, realPrice: 32000, offerPrice: 25222, discount: 13, size: 6, battery: 5500, storage: 128, operatingSystem: Android 12, networkType: 5G, camera1: 64, camera2: 6, hybridSim: Yes, clock: 2.5})
}


//  name,
//         simtype,
//         modelnumber,
//         category,
//         subcategory,
//         image,
//         mobileNumber,
//         displaysize,
//         operatingsystem,
//         processortype,
//         clockspeed,
//         internalstorage,
//         ram,
//         networktype,
//         batterycapicity,
//         camera1,
//         camera2,
//         camera3,
//         camera4,
//         hybridsimslot,
//         quantity,
//         colors,
//         price,
//         realprice,
//         discount,