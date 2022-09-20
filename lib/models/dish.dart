// To parse this JSON data, do
//
//     final category = categoryFromMap(jsonString);

import 'dart:convert';

class Dish {
  Dish({
    this.description,
    required this.name,
    required this.price,
    this.quantity
  });

  String? description;
  String name;
  num price;
  String? id;
  int? quantity;

  factory Dish.fromJson(String str) => Dish.fromMap(json.decode(str));

  // get quantity => null;

  String toJson() => json.encode(toMap());

  factory Dish.fromMap(Map<String, dynamic> json) => Dish(
        description: json["DESCRIPTION"],
        name: json["NAME"],
        price: json["PRICE"],
        quantity: json["QUANTITY"]
      );

  Map<String, dynamic> toMap() => {
        "DESCRIPTION": description,
        "NAME": name,
        "PRICE": price,
        "QUANTITY":quantity
      };
}
