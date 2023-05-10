class ShippingModel {
  List<ShippingDataModel> data = [];
  ShippingModel();
  ShippingModel.fromJson(Map<String, dynamic> json) {
    json["data"].forEach((element) {
      data.add(ShippingDataModel.fromJson(element));
    });
  }
}

class ShippingDataModel {
  late int id;
  late String departureTime;
  ShippingDataModel();
  ShippingDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    departureTime = json["departure_time"];
  }
}
