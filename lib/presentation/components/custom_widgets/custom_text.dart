import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final double fontSize;
  final Color fontColor;
  final String text;

  const CustomText(
      {Key? key,
      required this.text,
      required this.fontSize,
      required this.fontColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.ptSans(
          textStyle: TextStyle(color: fontColor, fontSize: fontSize),
          fontWeight: FontWeight.bold),
    );
  }
}
