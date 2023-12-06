// To parse this JSON data, do
//
//     final bookings = bookingsFromJson(jsonString);

import 'dart:convert';

List<Bookings> bookingsFromJson(String str) => List<Bookings>.from(json.decode(str).map((x) => Bookings.fromJson(x)));

String bookingsToJson(List<Bookings> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Bookings {
    String? id;
    String? user;
    String? fullname;
    String? phone;
    String? trip;
    String? bus;
    String? seat;
    String? luggage;
    String? price;
    String? location;
    String? payed;
    String? notes;
    DateTime? due;
    DateTime? created;

    Bookings({
        this.id,
        this.user,
        this.fullname,
        this.phone,
        this.trip,
        this.bus,
        this.seat,
        this.luggage,
        this.price,
        this.location,
        this.payed,
        this.notes,
        this.due,
        this.created,
    });

    factory Bookings.fromJson(Map<String, dynamic> json) => Bookings(
        id: json["id"],
        user: json["user"],
        fullname: json["fullname"],
        phone: json["phone"],
        trip: json["trip"],
        bus: json["bus"],
        seat: json["seat"],
        luggage: json["luggage"],
        price: json["price"],
        location: json["location"],
        payed: json["payed"],
        notes: json["notes"],
        due: json["due"] == null ? null : DateTime.parse(json["due"]),
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "fullname": fullname,
        "phone": phone,
        "trip": trip,
        "bus": bus,
        "seat": seat,
        "luggage": luggage,
        "price": price,
        "location": location,
        "payed": payed,
        "notes": notes,
        "due": due?.toIso8601String(),
        "created": created?.toIso8601String(),
    };
}
