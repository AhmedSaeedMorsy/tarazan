class ShippingTripModel {
  ShippingTripDataModel data = ShippingTripDataModel();
  ShippingTripModel();
  ShippingTripModel.fromJson(Map<String, dynamic> json) {
    data = ShippingTripDataModel.fromJson(json["data"]);
  }
}

class ShippingTripDataModel {
  late String shippingId;
  late String userId;
  late String categoryId;
  late String amount;
  String? productName;
  int? cost;
  late int id;
  ShippingTripDataModel();
  ShippingTripDataModel.fromJson(Map<String, dynamic> json) {
    shippingId = json["shipping_id"];
    userId = json["user_id"];
    categoryId = json["category_id"];
    amount = json["amount"];
    productName = json["product_name"];
    cost = json["cost"];
    id = json["id"];
  }
}
