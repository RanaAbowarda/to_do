class UserModel {
  String? name;
  String? email;
  String? id;
  UserModel({required this.email, required this.name, required this.id});

  UserModel.fromJson(Map<String, dynamic> data)
      : this(name: data["name"], email: data["email"], id: data["id"]);

  Map<String, dynamic> toJson() {
    return {"name": name, "email": email, "id": id};
  }
}
