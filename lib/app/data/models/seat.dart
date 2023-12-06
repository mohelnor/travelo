// To parse this JSON data, do
//
//     final seats = seatsFromJson(jsonString);

import 'dart:convert';

List<Seats> seatsFromJson(String str) => List<Seats>.from(json.decode(str).map((x) => Seats.fromJson(x)));

String seatsToJson(List<Seats> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Seats {
    String? id;
    String? seat;
    String? bus;
    String? taken;
    DateTime? date;

    Seats({
        this.id,
        this.seat,
        this.bus,
        this.taken,
        this.date,
    });

    factory Seats.fromJson(Map<String, dynamic> json) => Seats(
        id: json["id"],
        seat: json["seat"],
        bus: json["bus"],
        taken: json["taken"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "seat": seat,
        "bus": bus,
        "taken": taken,
        "date": date?.toIso8601String(),
    };
}
