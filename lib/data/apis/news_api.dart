import 'package:dio/dio.dart';
import 'package:weather_application/constants/constant_api_configuration.dart';
import 'package:weather_application/data/models/article_model.dart';

abstract class ApiProvider {}

class ApiNewsProvider extends ApiProvider {
  final Dio _dio = Dio(
    BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: connectionTimeOut,
        receiveTimeout: receiveTimeOut),
  );

  final List<String> searchKeywords;
  ApiNewsProvider({required this.searchKeywords});

  Future<dynamic> getArticles() async {
    try {
      Response response = await _dio.post("getArticles",
          queryParameters: _getApiParameters(),
          data: _getApiBody(searchKeywords));

      bool dataReceived;
      (response.statusCode == 200) ? dataReceived = true : dataReceived = false;

      if (!dataReceived) {
        return _getErrorResponse();
      }

      bool dataEmpty;
      int dataLength = response.data["articles"]["totalResults"];
      dataLength == 0 ? dataEmpty = true : dataEmpty = false;

      if (dataEmpty) {
        return _getEmptyResponse();
      }
      //
      else {
        return response.data["articles"]["results"];
      }
    }
    //
    catch (error) {
      return _getErrorResponse();
    }
  }

  Map<String, dynamic> _getApiBody(List<String> searchKeywords) {
    return {
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

  List<dynamic> _getErrorResponse() {
    List<dynamic> errorResponses = [];
    for (int i = 0; i < articleCount; i++) {
      errorResponses.add(Article.errorInResponse);
    }
    return errorResponses;
  }

  List<dynamic> _getEmptyResponse() {
    List<dynamic> emptyResponses = [];
    for (int i = 0; i < articleCount; i++) {
      emptyResponses.add(Article.emptyResponse);
    }
    return emptyResponses;
  }

  Map<String, dynamic> _getApiParameters() {
    return {"apiKey": apiKey};
  }
}
