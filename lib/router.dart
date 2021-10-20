import 'package:flutter/material.dart';
import 'package:weather_application/constants/routes.dart';
import 'package:weather_application/presentation/screens/home_page.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreenRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}
