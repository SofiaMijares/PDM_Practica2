import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.purple;
 
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.grey[900],
    //color primary
    primaryColor: primary,
    //app bar color
    appBarTheme: const AppBarTheme(color: primary, elevation: 0),
  );
}
