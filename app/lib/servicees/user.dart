import 'dart:convert';

List<User> UserFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String UserToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  String contact;
  int id;
  String name;

  User({
    required this.contact,
    required this.id,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    contact: json["contact"],
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "contact": contact,
    "id": id,
    "name": name,
  };
}

