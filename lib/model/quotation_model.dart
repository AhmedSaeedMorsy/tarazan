class QuotationModel {
  List<QuotationDataModel> data = [];
  QuotationModel();
  QuotationModel.fromJson(Map<String, dynamic> json) {
    json["data"].forEach((element) {
      data.add(QuotationDataModel.fromJson(element));
    });
  }
}

class QuotationDataModel {
  int? id;
  int? shippingId;
  int? userId;
  String? productName;
  int? amount;
  String? image;
  String? cost;
  QuotationDataModel();
  QuotationDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    shippingId = json["shipping_id"];
    userId = json["user_id"];
    productName = json["productName"];
    amount = json["amount"];
    image = json["image"];
    cost = json["cost"];
  }
}
