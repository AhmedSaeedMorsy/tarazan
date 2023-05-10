class HistoryShippingModel {
  List<HistoryShippingDataModel> data = [];
  HistoryShippingModel();
  HistoryShippingModel.fromJson(Map<String, dynamic> json) {
    json["data"].forEach((element) {
      data.add(HistoryShippingDataModel.fromJson(element));
    });
  }
}

class HistoryShippingDataModel {
  late int id;
  late int shippingId;
  late int categoryId;
  late String productName;
  late int amount;
  late String cost;
  late String createdAt;
  HistoryShippingDataModel();
  HistoryShippingDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    shippingId = json["shipping_id"];
    categoryId = json["category_id"];
    productName = json["product_name"];
    amount = json["amount"];
    cost = json["cost"];
    createdAt = json["created_at"];
  }
}
