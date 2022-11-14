
import 'package:flutter/material.dart';
import 'package:musicfindapp/models/menu_options.dart';
import 'package:musicfindapp/screens/details_screen.dart';
import 'package:musicfindapp/screens/favorites_screen.dart';
import 'package:musicfindapp/screens/home_screen.dart';
import 'package:musicfindapp/screens/login_screen.dart';

class AppRoutes {
  // static const initialRoute = 'login';
  //Manera de definir las rutas de la aplicacion
  static final menuOptions = <MenuOptions>[
    MenuOptions(route: 'favorites',screen: const FavoriteScreen()),
    MenuOptions(route: 'details',screen: const DetailScreen()),
    MenuOptions(route: 'login', screen: const LoginScreen())   
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    appRoutes.addAll({'home': (context) =>  const HomeScreen()});
    for (final option in menuOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }

    return appRoutes;
  }
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) =>  const LoginScreen());
  }
}

