
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class InputDecorationsBorderRadious {
  static InputDecoration authInputDecoration(
      {required String hintText,
      IconData? prefixIcon,
      IconButton? suffix}) {
    return InputDecoration(
      // contentPadding: EdgeInsets.all(10.0),
      filled: true,
      fillColor: Colors.white,
      hintText: hintText,
      
      labelStyle: const TextStyle(color: Colors.grey),
      suffixIcon: suffix,
      prefixIcon:
          prefixIcon != null ? Icon(prefixIcon, color: AppTheme.primary) : null,
      
      focusedBorder: OutlineInputBorder(
        
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(20),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(20),
      ),
      errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.red,
                      )),
      focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.red,
                      )),
    );
  }
}
