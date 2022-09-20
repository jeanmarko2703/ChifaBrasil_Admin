// To parse this JSON data, do
//
//     final schedule = scheduleFromMap(jsonString);

import 'dart:convert';

class Day {
    Day({
        this.id,
        required this.minClose,
        required this.hourClose,
        required this.hourOpen,
        required this.minOpen,
        required this.number
    });
    String ?id;
    int minClose;
    int hourClose;
    int minOpen;
    int hourOpen;
    int number;

    factory Day.fromJson(String str) => Day.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Day.fromMap(Map<String, dynamic> json) => Day(

        minClose: json["MIN_CLOSE"],
        hourClose: json["HOUR_CLOSE"],
        minOpen: json["MIN_OPEN"],
        hourOpen: json["HOUR_OPEN"],
        number: json["NUMBER"]
    );

    Map<String, dynamic> toMap() => {
        "HOUR_CLOSE": hourClose,
        "MIN_CLOSE": minClose,
        "HOUR_OPEN": hourOpen,
        "MIN_OPEN": minOpen,
        "NUMBER":number
    };
}
