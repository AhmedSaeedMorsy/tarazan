class UserModel {
  late String token;
  late UserData user;
  UserModel();
  UserModel.fromJson(Map<String, dynamic> json) {
    token = json["token"];
    user = UserData.fromJson(json["user"]);
  }
}

class UserData {
  late int id;
  late String name;
  late String role;
  late String email;
  late String phone;
  String? image;
  UserData();
  UserData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    role = json["role"];
    email = json["email"];
    phone = json["phone"];
    image = json["image"];
  }
}

class EditProfileModel {
  late UserData data;
  EditProfileModel();
  EditProfileModel.fromJson(Map<String, dynamic> json) {
    data = UserData.fromJson(json["data"]);
  }
}
