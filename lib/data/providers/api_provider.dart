import 'package:dio/dio.dart';
import 'package:weather_application/constants/constant_api_configuration.dart';
import 'package:weather_application/data/models/article_model.dart';

class ApiProvider {
  final Dio _dio = Dio(
    BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: connectionTimeOut,
        receiveTimeout: receiveTimeOut),
  );

  final Map<String, dynamic> apiBody;
  ApiProvider({required this.apiBody});

  Future<dynamic> getArticles() async {
    try {
      Response response = await _dio.post("getArticles",
          queryParameters: apiParameters, data: apiBody);
      if (response.statusCode == 200) {
        if (response.data["articles"]["totalResults"] == 0) {
          List<dynamic> emptyResponses = [];
          for (int i = 0; i < articleCount; i++) {
            emptyResponses.add(Article.emptyResponse);
          }
          return emptyResponses;
        }
        return response.data["articles"]["results"];
      }
      List<dynamic> errorResponses = [];
      for (int i = 0; i < articleCount; i++) {
        errorResponses.add(Article.errorInResponse);
      }
      return errorResponses;
    } catch (error) {
      List<dynamic> errorResponses = [];
      for (int i = 0; i < articleCount; i++) {
        errorResponses.add(Article.errorInResponse);
      }
      return errorResponses;
    }
  }
}
