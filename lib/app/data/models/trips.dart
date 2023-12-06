// To parse this JSON data, do
//
//     final trips = tripsFromJson(jsonString);

import 'dart:convert';

List<Trips> tripsFromJson(String str) => List<Trips>.from(json.decode(str).map((x) => Trips.fromJson(x)));

String tripsToJson(List<Trips> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Trips {
    String? id;
    String? location;
    String? destination;
    String? time;
    DateTime? due;
    String? company;

    Trips({
        this.id,
        this.location,
        this.destination,
        this.time,
        this.due,
        this.company,
    });

    factory Trips.fromJson(Map<String, dynamic> json) => Trips(
        id: json["id"],
        location: json["location"],
        destination: json["destination"],
        time: json["time"],
        due: json["due"] == null ? null : DateTime.parse(json["due"]),
        company: json["company"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "location": location,
        "destination": destination,
        "time": time,
        "due": due?.toIso8601String(),
        "company": company,
    };
}
