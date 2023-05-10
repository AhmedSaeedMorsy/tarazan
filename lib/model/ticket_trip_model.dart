class TicketTirpModel {
  TicketTirpDataModel data = TicketTirpDataModel();
  TicketTirpModel();
  TicketTirpModel.fromJson(Map<String, dynamic> json) {
    data = TicketTirpDataModel.fromJson(json["data"]);
  }
}

class TicketTirpDataModel {
  late int cost;
  TicketTirpDataModel();
  TicketTirpDataModel.fromJson(Map<String, dynamic> json) {
    cost = json["cost"];
  }
}
