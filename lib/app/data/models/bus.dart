// To parse this JSON data, do
//
//     final bus = busFromJson(jsonString);

import 'dart:convert';

List<Bus> busFromJson(String str) => List<Bus>.from(json.decode(str).map((x) => Bus.fromJson(x)));

String busToJson(List<Bus> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Bus {
    String? id;
    String? name;
    String? plate;
    String? company;
    String? seats;
    String? ticketPrice;
    String? status;
    String? trip;
    String? date;
    String? details;

    Bus({
        this.id,
        this.name,
        this.plate,
        this.company,
        this.seats,
        this.ticketPrice,
        this.status,
        this.trip,
        this.date,
        this.details,
    });

    factory Bus.fromJson(Map<String, dynamic> json) => Bus(
        id: json["id"],
        name: json["name"],
        plate: json["plate"],
        company: json["company"],
        seats: json["seats"],
        ticketPrice: json["ticketPrice"],
        status: json["status"],
        trip: json["trip"],
        date: json["date"],
        details: json["details"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "plate": plate,
        "company": company,
        "seats": seats,
        "ticketPrice": ticketPrice,
        "status": status,
        "trip": trip,
        "date": date,
        "details": details,
    };
}
