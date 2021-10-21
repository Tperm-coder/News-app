import 'package:flutter/material.dart';
import 'package:weather_application/constants/constant_api_configuration.dart';
import 'package:weather_application/constants/constant_colors.dart';
import 'package:weather_application/presentation/components/custom_widgets/custom_text.dart';

class SearchResultItem extends StatefulWidget {
  final String title;
  final String imgUrl;
  final double parentWidth;
  const SearchResultItem(
      {Key? key,
      required this.parentWidth,
      required this.imgUrl,
      required this.title})
      : super(key: key);

  @override
  _SearchResultItemState createState() => _SearchResultItemState();
}

class _SearchResultItemState extends State<SearchResultItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(mainGreyColor),
        ),
        child: Row(
          children: [
            SizedBox(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: ((widget.title == "something went wrong")
                      ? Image.asset(altImgConnectionError, fit: BoxFit.fill)
                      : ((widget.title == "nothing was found")
                          ? Image.asset(altImgNothingFound, fit: BoxFit.fill)
                          : Image.network(
                              widget.imgUrl,
                              fit: BoxFit.fill,
                            ))),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: widget.parentWidth - (100 + 8 * 2 + 10 * 2),
                child: CustomText(
                    text: widget.title,
                    fontSize: 13,
                    fontColor: const Color(mainDarkColor)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
