// To parse this JSON data, do
//
//     final city = cityFromJson(jsonString);

import 'dart:convert';

List<City> cityFromJson(String str) => List<City>.from(json.decode(str).map((x) => City.fromJson(x)));

String cityToJson(List<City> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class City {
    String? id;
    String? name;
    String? details;

    City({
        this.id,
        this.name,
        this.details,
    });

    factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        details: json["details"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "details": details,
    };
}
