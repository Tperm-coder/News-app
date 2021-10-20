import 'package:weather_application/data/providers/api_body_provider.dart';
import 'package:weather_application/data/providers/api_provider.dart';
import 'package:weather_application/data/models/article_model.dart';

class ArticleProvider {
  final List<String> searchKeyWords;
  late ApiBody apiBody = ApiBody(searchKeywords: searchKeyWords);

  ArticleProvider({required this.searchKeyWords});
  Future<List<dynamic>> getArticles() async {
    final articles = await ApiProvider(apiBody: apiBody.apiBody).getArticles();
    return articles.map((article) => Article.fromJson(article)).toList();
  }
}
