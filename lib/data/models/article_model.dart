import 'package:weather_application/constants/api_configuration.dart';

class Article {
  final String articleTitle;
  final String articleContent;
  final String articleImgUrl;
  final String articleSource;

  Article(
      {required this.articleTitle,
      required this.articleContent,
      required this.articleSource,
      required this.articleImgUrl});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        articleContent: json["body"] as String,
        articleTitle: json["title"] as String,
        articleImgUrl: json["image"] as String,
        articleSource: json["url"] as String);
  }

  static Map<String, String> errorInResponse = {
    "body": "something went wrong",
    "title": "something went wrong",
    "image": altImage,
    "url": ""
  };
  static Map<String, String> emptyResponse = {
    "body": "nothing was found",
    "title": "nothing was found",
    "image": altImage,
    "url": ""
  };
}
