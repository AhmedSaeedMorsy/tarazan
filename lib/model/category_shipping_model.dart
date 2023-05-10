class CategoryShippingModel {
  List<CategoryShippingDataModel> data = [];
  CategoryShippingModel();
  CategoryShippingModel.fromJson(Map<String, dynamic> json) {
    json["data"].forEach((element) {
      data.add(CategoryShippingDataModel.fromJson(element));
    });
  }
}

class CategoryShippingDataModel {
  late int id;
  late String name;
  String ? image;
  String ? basicCost;
  String ? fastCost;
  CategoryShippingDataModel();
  CategoryShippingDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    image = json["image"];
    basicCost = json["basic_cost"];
    fastCost = json["fast_cost"];
  }
}
