import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_application/constants/constant_routes.dart';
import 'package:weather_application/data/repositories/article_repository.dart';
import 'package:weather_application/logic/app_blocks/newsBlock/news_block.dart';
import 'package:weather_application/presentation/screens/choosed_article_screen.dart';
import 'package:weather_application/presentation/screens/home_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //
      case homeScreenRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => NewsBlock(
              articleRepository: ArticleRepository(searchKeyWords: []),
            ),
            child: const HomeScreen(),
          ),
        );

      //
      case choosedArticleScreenRoute:
        return MaterialPageRoute(
          //
          builder: (BuildContext context) {
            return const ChoosedArticleScreen();
          },
          //
          settings: settings,
        );
    }
  }
}
