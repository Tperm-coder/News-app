import 'package:dio/dio.dart';
import 'package:weather_application/constants/api_configuration.dart';
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
          return [Article.emptyResponse];
        }
        return response.data["articles"]["results"];
      }
      return [Article.errorInResponse];
    } catch (error) {
      return [Article.errorInResponse];
    }
  }
}
