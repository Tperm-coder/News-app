import 'package:flutter/material.dart';
import 'package:weather_application/data/providers/api_provider.dart';
import 'package:weather_application/data/models/article_model.dart';
import 'package:weather_application/data/providers/article_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("home screen"),
            TextButton(
                child: Text("get data"),
                onPressed: () async {
                  print("start");
                  ArticleProvider art =
                      ArticleProvider(searchKeyWords: ["America"]);
                  List<dynamic> temp = await art.getArticles();
                  print(temp[0].articleContent);
                  print("end");
                })
          ],
        ),
      ),
    );
  }
}
