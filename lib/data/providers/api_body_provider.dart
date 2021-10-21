import 'package:weather_application/constants/constant_api_configuration.dart';

class ApiBody {
  final List<String> searchKeywords;
  ApiBody({required this.searchKeywords});

  late Map<String, dynamic> apiBody = {
    "action": "getArticles",
    "keyword": searchKeywords,
    "lang": ["eng", "deu"],
    "articlesCount": articleCount,
    "articlesSortBy": "sourceImportance",
    "articlesArticleBodyLen": -1,
    "includeArticleConcepts": false,
    "includeArticleCategories": false,
    "includeArticleImage": true,
    "includeArticleSocialScore": false,
    "includeArticleLocation": false,
    "resultType": "articles",
    "apiKey": apiKey,
    "forceMaxDataTimeWindow": 31
  };
}
