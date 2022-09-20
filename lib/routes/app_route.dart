import 'package:flutter/material.dart';
import '../models/menu_option.dart';
import '../screens/screens.dart';

class AppRoute {
  static const initialRoute = 'navigationScreen';

  static final menuOption = <MenuOption>[
    MenuOption(route: 'homeScreen', name: 'home', screen: const HomeScreen()),
    // MenuOption(route: 'ordersScreen', name: 'orders', screen: const OrdersScreen()),
    MenuOption(route: 'scheduleScreen', name: 'schedule', screen: const ScheduleScreen()),
    MenuOption(route: 'categoriesScreen', name: 'categories', screen: const CategoriesScreen()),
    // MenuOption(route: 'salesScreen', name: 'sales', screen: const SalesScreen()),
    
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    appRoutes.addAll(
        {'informationScreen': (BuildContext context) => const InformationScreen()});
        appRoutes.addAll(
        {'homeScreen': (BuildContext context) => const HomeScreen()});
         appRoutes.addAll(
        {'ordersScreen': (BuildContext context) => const OrdersScreen()});
         appRoutes.addAll(
        {'categoriesScreen': (BuildContext context) => const CategoriesScreen()});
         appRoutes.addAll(
        {'salesScreen': (BuildContext context) => const SalesScreen()});
         appRoutes.addAll(
        {'scheduleScreen': (BuildContext context) => const ScheduleScreen()});
         appRoutes.addAll(
        {'navigationScreen': (BuildContext context) => const NavigationScreen()});
         appRoutes.addAll(
        {'orderDetailsScreen': (BuildContext context) => const OrderDetailsScreen()});
        
        appRoutes.addAll(
        {'categoriesContentScreen': (BuildContext context) => const CategoriesContentScreen()});
         appRoutes.addAll(
        {'addDishScreen': (BuildContext context) => const AddDishScreen()});
   

    return appRoutes;
  }
}