import 'dart:convert';


import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../models/models.dart';

class CategoriesService extends ChangeNotifier {
  final String _baseUrl = 'chifabrasil-app-default-rtdb.firebaseio.com';
  

  final List<Category> categories = [];
  bool isLoading = true;
  CategoriesService() {
    loadCategories();
  }
  Future loadCategories() async {
    isLoading = true;
    notifyListeners();
    // final String idToken= await storage.read(key: 'token')??'';
    final url = Uri.https(_baseUrl, 'CATEGORIES.json',
    //  {
    //   'auth':await storage.read(key: 'tokenId')??''
    // }
    );
    print(url);
    final resp = await http.get(url);

    final Map<String, dynamic> categoriesMap = json.decode(resp.body);

    categoriesMap.forEach((key, value) {
      final tempCategory = Category.fromMap(value);
      tempCategory.id = key;
      categories.add(tempCategory);
    });
    isLoading = false;
    notifyListeners();
    return categories;
  }
}
