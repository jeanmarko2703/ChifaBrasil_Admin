// To parse this JSON data, do
//
//     final category = categoryFromMap(jsonString);

import 'dart:convert';

class Printer {
  Printer({
  
    required this.id,
    required this.address
    
  });

  
  String address;
 
  int? id;
  

  factory Printer.fromJson(String str) => Printer.fromMap(json.decode(str));

  // get quantity => null;

  String toJson() => json.encode(toMap());

  factory Printer.fromMap(Map<String, dynamic> json) => Printer(
        id: json["_id"],
        address: json["address"],
       
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "address": address
      };
}
