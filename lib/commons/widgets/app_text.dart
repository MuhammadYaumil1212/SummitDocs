import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? fontColor;
  const AppText({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 16.0,
    this.fontColor = Colors.black12,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: fontColor,
      ),
    );
  }
}
