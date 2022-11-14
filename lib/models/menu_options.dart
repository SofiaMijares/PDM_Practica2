import 'package:flutter/material.dart' show Widget;

class MenuOptions {
  final String route;
  final Widget screen;

  MenuOptions(
      {
        required this.route,
        required this.screen
      }
  );
}
