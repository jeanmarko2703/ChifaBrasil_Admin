import 'dart:async';
import 'dart:convert';



import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;


import '../models/dish.dart';
import '../models/order.dart';

class OrdersService extends ChangeNotifier {
  final String _baseUrl = 'chifabrasil-app-default-rtdb.firebaseio.com';
  final List<Dish> dishes = [];
  final List<Order> orders = [];
  
 
  bool isLoading = false;


  OrdersService() {
    loadOrdersToday('PENDIENTE');

  }
  String splitDay(String date){

  String s = date;
  int idx = s.indexOf("/");
  List<String> parts = [s.substring(0,idx).trim(), s.substring(idx+1).trim()];
  
    print('---');
    print(parts[0]);
    return parts[0];

  }
  Future<List<Order>> loadOrdersToday(String status) async {
    String day= DateTime.now().day.toString() ; 
    isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'ORDERS.json');
    final resp = await http.get(url);

    final Map<String, dynamic> ordersMap = json.decode(resp.body)!=null? json.decode(resp.body):{};
    orders.clear();
    ordersMap.forEach((key, value) {
      final tempOrder = Order.fromMap(value);
      tempOrder.id = key;
      if(tempOrder.status==status && splitDay(tempOrder.date)==day)
      {
        orders.add(tempOrder);
      }
      
    });
    
    isLoading = false;
    notifyListeners();
    print('el tamanio de la lista en el servicio');
    print(orders.length);
    
    return orders;
    

  }
  Future<List<Order>> loadOrders() async {
    
    isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'ORDERS.json');
    final resp = await http.get(url);

    final Map<String, dynamic> ordersMap = json.decode(resp.body)!=null? json.decode(resp.body):{};
    orders.clear();
    ordersMap.forEach((key, value) {
      final tempOrder = Order.fromMap(value);
      tempOrder.id = key;
      
      orders.add(tempOrder);
      
    });
    
    isLoading = false;
    notifyListeners();
    print('el tamanio de la lista en el servicio');
    print(orders.length);
    
    return orders;
    

  }

  void clearOrders(){
    orders.clear();
  }

  void clearDish(){
    dishes.clear();
  }
  

   Future<List<Dish>> loadDishOrders(String orderId) async {
    final url = Uri.https(_baseUrl, 'ORDERS/$orderId/DISHES.json');
    final resp = await http.get(url);

   
    dishes.clear();
    final Map<String, dynamic> dishesMap =
        json.decode(resp.body) ?? <String, dynamic>{};
    if (dishesMap.isNotEmpty) {
      // print(dishesMap);
      dishesMap.forEach((key, value) {
        final tempDish = Dish.fromMap(value);
        tempDish.id = key;
        
        dishes.add(tempDish);
        
      });
    }

    
    
    return dishes;
  }

  Future<String> changeStatusOrder( String status, String idOrder ) async {
    if(idOrder=='')return 'No hay idOrder';

    final url = Uri.https( _baseUrl, 'ORDERS/$idOrder/STATUS.json');
    final resp = await http.put( url, body: jsonEncode(status));
    final decodedData = json.decode( resp.body );
    
    
    
    

    print('order como lista');

    print(decodedData);

    

    return decodedData;

  }

   
}
