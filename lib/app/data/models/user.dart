// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
    String? id;
    String? user;
    String? name;
    String? password;
    String? phone;
    String? address;
    String? city;
    String? role;
    DateTime? created;

    User({
        this.id,
        this.user,
        this.name,
        this.password,
        this.phone,
        this.address,
        this.city,
        this.role,
        this.created,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        user: json["user"],
        name: json["name"],
        password: json["password"],
        phone: json["phone"],
        address: json["address"],
        city: json["city"],
        role: json["role"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "name": name,
        "password": password,
        "phone": phone,
        "address": address,
        "city": city,
        "role": role,
        "created": created?.toIso8601String(),
    };
}
