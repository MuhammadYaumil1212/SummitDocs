import 'package:SummitDocs/commons/constants/string.dart';
import 'package:SummitDocs/commons/widgets/app_text.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String errorMessage;
  final String imageString;
  const ErrorScreen({
    super.key,
    required this.errorMessage,
    required this.imageString,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppString.errorImages),
          AppText(
            text: "Stop!",
            fontWeight: FontWeight.w700,
            fontSize: 28,
          ),
          AppText(
            text: errorMessage,
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ],
      ),
    );
  }
}
