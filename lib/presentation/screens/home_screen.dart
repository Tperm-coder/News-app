import 'package:flutter/material.dart';
import 'package:weather_application/constants/constant_api_configuration.dart';
import 'package:weather_application/constants/constant_colors.dart';
import 'package:weather_application/constants/constant_news_search_fields.dart';
import 'package:weather_application/constants/constant_routes.dart';
import 'package:weather_application/data/providers/article_provider.dart';
import 'package:weather_application/presentation/components/custom_widgets/custom_text.dart';
import 'package:weather_application/presentation/components/custom_widgets/search_item.dart';
import 'package:weather_application/presentation/components/custom_widgets/search_result_item.dart';
import 'package:loading_indicator/loading_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Widget loadingIndicator = const LoadingIndicator(
    indicatorType: Indicator.ballScale,
    colors: [Color(mainDarkColor)],
    strokeWidth: 2,
  );

  int indexOfSelected = 0;
  late double globalScreenWidth;
  late ListView searchTopics;
  late Widget? searchResults = loadingIndicator;
  late List<dynamic> receivedArticles;

  @override
  void initState() {
    super.initState();
    searchTopics = _getSearchTopics();
    _getSearchResults([constantSearchFields[indexOfSelected]]);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenDimensions = MediaQuery.of(context).size;
    final double screenWidth = screenDimensions.width;
    final double screenHeight = screenDimensions.height;
    globalScreenWidth = screenWidth;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: TextField(
                      autofocus: false,
                      onSubmitted: (value) {
                        setState(() {
                          searchResults = loadingIndicator;
                          indexOfSelected = -1;
                          _updateSearchTopics();
                        });
                        _getSearchResults(value.split(' '));
                      },
                      cursorColor: const Color(mainDarkColor),
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.search_rounded,
                            color: Color(0xff888693)),
                        fillColor: const Color(mainGreyColor),
                        filled: true,
                        hintText: "Search News",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: CustomText(
                                      text: "Number of Articles per search",
                                      fontSize: 15,
                                      fontColor: Color(mainDarkColor),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                    child: TextField(
                                      onSubmitted: (value) {
                                        setState(() {
                                          articleCount = int.parse(value);
                                          Navigator.of(context).pop();
                                        });
                                      },
                                      keyboardType: TextInputType.number,
                                      autofocus: false,
                                      cursorColor: const Color(mainDarkColor),
                                      textAlign: TextAlign.start,
                                      decoration: InputDecoration(
                                        fillColor: const Color(mainGreyColor),
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    },
                    child: const Icon(
                      Icons.view_headline_rounded,
                      size: 30,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        CustomText(
                            text: "Good Morning",
                            fontSize: 30,
                            fontColor: Color(mainDarkColor)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        CustomText(
                            text: " Explore the world by one Click",
                            fontSize: 15,
                            fontColor: Color(mainDarkColor)),
                      ],
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                child: SizedBox(
                  height: screenHeight * 0.3,
                  width: screenWidth * 0.8,
                  child: Image.asset("assets/imgs/app.jpg"),
                ),
              ),
              SizedBox(
                height: 60,
                child: searchTopics,
              ),
              Expanded(child: searchResults ?? Container()),
            ],
          ),
        ),
      ),
    );
  }

  ListView _getSearchTopics() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: constantSearchFields.length,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          child: SearchItem(
            text: constantSearchFields[index],
            isSelected: ((indexOfSelected == index) ? true : false),
          ),
          onTap: () {
            setState(() {
              searchResults = loadingIndicator;
              indexOfSelected = index;
              _updateSearchTopics();
            });
            _getSearchResults([constantSearchFields[indexOfSelected]]);
          },
        );
      },
    );
  }

  void _updateSearchTopics() {
    setState(() {
      searchTopics = _getSearchTopics();
    });
  }

  void _getSearchResults(List<String> keyWords) async {
    print("loading");
    ArticleProvider art = ArticleProvider(searchKeyWords: keyWords);
    print(keyWords);
    receivedArticles = await art.getArticles();
    setState(() {
      searchResults = ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: articleCount,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              child: SearchResultItem(
                  title: receivedArticles[index].articleTitle,
                  imgUrl: receivedArticles[index].articleImgUrl,
                  parentWidth: globalScreenWidth * 0.85),
              onTap: () {
                Navigator.pushNamed(context, choosedArticleScreenRoute,
                    arguments: receivedArticles[index]);
              },
            );
          });
    });
    print("DONE");
  }
}
