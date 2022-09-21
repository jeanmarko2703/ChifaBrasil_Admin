// To parse this JSON data, do
//
//     final order = orderFromMap(jsonString);

import 'dart:convert';



class Order {
    Order({
        // this.dishes,
        required this.status,
        required this.houseNumber,
        this.id,
        required this.note,
        required this.paymentMethod,
        required this.phone,
        required this.lat,
        required this.lng,
        required this.street,
        required this.user,
        required this.date,
        required this.userName
        
    });

    String status;
    String houseNumber;
    String? id;
    String note;
    String paymentMethod;
    int phone;
    double lat;
    double lng;
    String street;
    String user;
    String date;
    String userName;
    

    factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Order.fromMap(Map<String, dynamic> json) => Order(

        
        houseNumber: json["HOUSE_NUMBER"],
        status: json["STATUS"],
        note: json["NOTE"],
        paymentMethod: json["PAYMENT_METHOD"],
        phone: json["PHONE"],
        lat: json["LAT"],
        lng: json["LNG"],
        street: json["STREET"],
        user: json["USER"],
        date: json["DATE"],
        userName: json["USER_NAME"]
    );

    Map<String, dynamic> toMap() => {
        
        "HOUSE_NUMBER": houseNumber,
        "STATUS":status,
        "NOTE": note,
        "PAYMENT_METHOD": paymentMethod,
        "PHONE": phone,
        "LAT": lat,
        "LNG": lng,
        "STREET": street,
        "USER": user,
        "DATE":date,
        "USER_NAME":userName
    };
}



