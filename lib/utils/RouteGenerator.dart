import 'package:Bacon/screens/home/Home.dart';
import 'package:Bacon/screens/login/Login.dart';
import 'package:flutter/material.dart';

class RouteGenerator {

  static Route<MaterialPageRoute> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
      case 'login':
        return MaterialPageRoute(builder: (_) => Login());
      default:
        return _errorRoute();
    }
  }

  static _errorRoute() {
    return MaterialPageRoute(builder: (_) => Login());
  }

}
