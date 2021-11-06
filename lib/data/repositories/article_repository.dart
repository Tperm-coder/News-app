import 'package:weather_application/data/apis/news_api.dart';
import 'package:weather_application/data/models/article_model.dart';

class ArticleRepository {
  List<String> searchKeyWords;
  ArticleRepository({required this.searchKeyWords});
  Future<List<dynamic>> getArticles() async {
    final articles =
        await ApiNewsProvider(searchKeywords: searchKeyWords).getArticles();
    return articles.map((article) => Article.fromJson(article)).toList();
  }
}
