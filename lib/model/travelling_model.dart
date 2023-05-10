class TravellingModel {
  List<TravellingDataModel> data = [];
  TravellingModel();
  TravellingModel.fromJson(Map<String, dynamic> json) {
    json["data"].forEach((element) {
      data.add(TravellingDataModel.fromJson(element));
    });
  }
}

class TravellingDataModel {
  late int id;
  late int typeId;
  late String fromLocation;
  late String toLocation;
  late String departureTime;
  late String arrivalTime;
  late String cost;
  late int seats;
  TravellingDataModel();
  TravellingDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    typeId = json["type_id"];
    fromLocation = json["from_location"];
    toLocation = json["to_location"];
    departureTime = json["departure_time"];
    arrivalTime = json["arrival_time"];
    cost = json["cost"];
    seats = json["remaining_seats"];
  }
}
