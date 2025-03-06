import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? fontColor;
  final String? fontFamily;
  final TextAlign? textAlign;

  const AppText({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 16.0,
    this.fontColor = Colors.black,
    this.fontFamily = "Geist",
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: fontColor,
      ),
    );
  }
}
