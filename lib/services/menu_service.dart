import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../helpers/debouncer.dart';
import '../models/models.dart';

class MenuService extends ChangeNotifier {
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

  Future<bool> updateMenuOpen() async {
    print('MenuUpdate');
    final url = Uri.https(_baseUrl, 'MENU/ACCESS.json');
    final resp = await http.put(url, body: jsonEncode(true));
    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  
  }
  Future<bool> updateMenuClose() async {
    print('MenuUpdate');
    final url = Uri.https(_baseUrl, 'MENU/ACCESS.json');
    final resp = await http.put(url, body: jsonEncode(false));
    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  
  }
}
