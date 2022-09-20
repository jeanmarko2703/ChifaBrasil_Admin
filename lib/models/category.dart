// To parse this JSON data, do
//
//     final categories = categoriesFromMap(jsonString);

import 'dart:convert';



class Category {
  Category({
    required this.name,
    this.image,
    //  this.dishes
  });

  String name;
  String? image;
  String? id;
  // List<Dish>? dishes;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        name: json["NAME"],
        image: json["IMAGE"],
        // dishes: List<Dish>.from(json["DISHES"].map((x) => Dish.fromMap(x)))
      );

  Map<String, dynamic> toMap() => {
        "NAME": name, "IMAGE": image,
        // "DISHES": dishes
      };
}
