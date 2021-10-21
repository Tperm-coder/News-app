import 'package:flutter/material.dart';
import 'package:weather_application/constants/constant_routes.dart';
import 'package:weather_application/presentation/screens/choosed_article_screen.dart';
import 'package:weather_application/presentation/screens/home_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreenRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case choosedArticleScreenRoute:
        return MaterialPageRoute(
            builder: (BuildContext context) {
              return ChoosedArticleScreen();
            },
            settings: settings);
    }
  }
}
