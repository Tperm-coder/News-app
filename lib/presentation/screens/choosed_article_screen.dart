import 'package:flutter/material.dart';
import 'package:weather_application/data/models/article_model.dart';
import 'package:weather_application/presentation/components/custom_widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

class ChoosedArticleScreen extends StatefulWidget {
  const ChoosedArticleScreen({Key? key}) : super(key: key);

  @override
  _ChoosedArticleScreenState createState() => _ChoosedArticleScreenState();
}

class _ChoosedArticleScreenState extends State<ChoosedArticleScreen> {
  @override
  Widget build(BuildContext context) {
    final choosedArticle =
        ModalRoute.of(context)!.settings.arguments as Article;
    final Size screenDimensions = MediaQuery.of(context).size;
    final double screenWidth = screenDimensions.width;
    final double screenHeight = screenDimensions.height;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(choosedArticle.articleImgUrl),
                    fit: BoxFit.fill),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: screenHeight * 0.5,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black38,
                        Colors.black,
                      ],
                    )),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.45),
                  SizedBox(
                    width: screenWidth * 0.85,
                    child: CustomText(
                      text: choosedArticle.articleTitle,
                      fontSize: 20,
                      fontColor: Colors.white,
                    ),
                  ),
                  Divider(
                    height: 20,
                    color: Colors.white,
                    thickness: 3.5,
                    endIndent: (screenWidth * 0.15) / 2,
                    indent: (screenWidth * 0.15) / 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        _launchURL(choosedArticle.articleSource);
                      },
                      child: SizedBox(
                        width: screenWidth * 0.85,
                        child: Text(
                          choosedArticle.articleSource,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: screenWidth * 0.85,
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          SizedBox(
                            child: CustomText(
                              text: choosedArticle.articleContent,
                              fontSize: 15,
                              fontColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

void _launchURL(String url) async =>
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
