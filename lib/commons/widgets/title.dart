import 'package:SummitDocs/commons/widgets/app_text.dart';
import 'package:flutter/material.dart';

class HomeTitle extends StatelessWidget {
  final String title;
  final String description;
  const HomeTitle({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: title,
          fontSize: 28,
          fontWeight: FontWeight.w700,
        ),
        AppText(
          text: description,
          fontSize: 18,
        ),
      ],
    );
  }
}
