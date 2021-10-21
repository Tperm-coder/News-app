import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';
import 'package:weather_application/constants/constant_colors.dart';
import 'package:weather_application/presentation/components/custom_widgets/custom_text.dart';

class SearchItem extends StatefulWidget {
  final String text;
  final bool isSelected;
  const SearchItem({Key? key, required this.text, required this.isSelected})
      : super(key: key);

  @override
  _SearchItemState createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  Color btnClr = Color(mainDarkColor);
  Color fontClr = Color(mainGreyColor);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: widget.isSelected ? btnClr : fontClr),
        child: Center(
          child: CustomText(
            text: widget.text,
            fontColor: widget.isSelected ? fontClr : btnClr,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
