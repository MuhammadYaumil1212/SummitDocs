import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? fontColor;
  final TextStyle? fontFamily;
  final TextAlign? textAlign;

  const AppText({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 16.0,
    this.fontColor = Colors.black,
    this.fontFamily,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: fontFamily?.copyWith(
            fontWeight: fontWeight,
            fontSize: fontSize,
            color: fontColor,
          ) ??
          GoogleFonts.roboto(
            fontWeight: fontWeight,
            fontSize: fontSize,
            color: fontColor,
          ),
    );
  }
}
