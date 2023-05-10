class HistoryTicketModel {
  List<HistoryTicketDataModel> data = [];
  HistoryTicketModel();
  HistoryTicketModel.fromJson(Map<String, dynamic> json) {
    json["data"].forEach((element) {
      data.add(HistoryTicketDataModel.fromJson(element));
    });
  }
}

class HistoryTicketDataModel {
  late int id;
  late int travelId;
  late int seats;
  late String cost;
  late String createdAt;
  Travel travel = Travel();
  HistoryTicketDataModel();
  HistoryTicketDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    travelId = json["travel_id"];
    seats = json["seats"];
    cost = json["cost"];
    createdAt = json["created_at"];
    travel = Travel.fromJson(json["travel"]);
  }
}

class Travel {
  late int typeId;
  Travel();
  Travel.fromJson(Map<String, dynamic> json) {
    typeId = json["type_id"];
  }
}
