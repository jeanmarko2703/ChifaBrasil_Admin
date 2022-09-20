import 'package:flutter/material.dart';

class  AppTheme {
  static const Color primary = Color.fromRGBO(255, 75, 58, 1);
  static const secondColor = Color.fromRGBO(173, 173, 175, 1);
  static const backgroundColor = Color.fromRGBO(246, 246, 249, 1);
  static const subtitleStyle =
      TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
  static const statusActiveStyle = TextStyle(
      color: Colors.transparent,
      decoration: TextDecoration.underline,
      decorationThickness: 2,
      shadows: [Shadow(color: AppTheme.primary, offset: Offset(0, -5))],
      decorationColor: AppTheme.primary);
  static const statusStyle = TextStyle(
      color: Colors.transparent,
      
      shadows: [Shadow(color: Colors.grey, offset: Offset(0, -5))],
      );

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    //color primario
    primaryColor: const Color.fromRGBO(255, 75, 58, 1),

    scaffoldBackgroundColor: backgroundColor,

    scrollbarTheme: ScrollbarThemeData(
      showTrackOnHover: false,
      thumbColor: MaterialStateProperty.all(AppTheme.primary.withOpacity(0.4)),
      thickness: MaterialStateProperty.all(5.0),
    ),

    //appbar theme
    appBarTheme: const AppBarTheme(
        toolbarHeight: 100,
        color: backgroundColor,
        elevation: 0,
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 35)),
    textButtonTheme:
        TextButtonThemeData(style: TextButton.styleFrom(primary: primary)),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primary, elevation: 5),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            primary: primary, shape: const StadiumBorder(), elevation: 0)),

    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: primary),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10), topRight: Radius.circular(10))),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10), topRight: Radius.circular(10))),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: primary),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10), topRight: Radius.circular(10))),
    ),
  );
}
