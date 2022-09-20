import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../helpers/debouncer.dart';
import '../models/models.dart';

class DishesService extends ChangeNotifier {
  final String _baseUrl = 'chifabrasil-app-default-rtdb.firebaseio.com';

  List<Dish> dishes = [];
  String currentCategory = '';

  bool isLoading = true;
  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  // DishessService() {
  //   loadDishes();
  // }

  Future<List<Dish>> loadDishes(String categoryId) async {
    final url = Uri.https(_baseUrl, 'CATEGORIES/$categoryId/DISHES.json');
    final resp = await http.get(url);

    dishes.clear();

    final Map<String, dynamic> dishesMap =
        json.decode(resp.body) ?? <String, dynamic>{};
    if (dishesMap.isNotEmpty) {
      dishesMap.forEach((key, value) {
        final tempDish = Dish.fromMap(value);
        tempDish.id = key;
        dishes.add(tempDish);
      });
    }

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = categoryId;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());

    return dishes;
  }
  Future<String> updateDish( String categoryId,Dish dish, String idDish ) async {
   
    print('updateDish');
    final url = Uri.https( _baseUrl, 'CATEGORIES/$categoryId/DISHES/$idDish.json');
    final resp = await http.put( url, body: dish.toJson());
    final decodedData = json.decode( resp.body );
    
    

    

    print(decodedData);

    return '';

  }

   Future<String> createDish( String categoryId,Dish dish) async {
    

    final url = Uri.https( _baseUrl, 'CATEGORIES/$categoryId/DISHES.json');
    final resp = await http.post( url, body: dish.toJson());
    final decodedData = json.decode( resp.body );
    

    return '';

  }
   Future<String> deleteDish( String categoryId,String dishId) async {
    
print('createDish');
    final url = Uri.https( _baseUrl, 'CATEGORIES/$categoryId/DISHES/$dishId.json');
    final resp = await http.delete( url);
    final decodedData = json.decode( resp.body );
    print(url);
    

    print('respuesta');

    print(resp);

    return '';

  }
}
