import 'package:SummitDocs/commons/widgets/app_text.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback action;
  final Color? fontColor;
  final Color? backgroundColor;
  final Color? borderColor;

  const AppButton({
    super.key,
    required this.text,
    required this.action,
    this.fontColor,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: action,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
          side: BorderSide(color: borderColor ?? Colors.transparent),
        ),
        child: AppText(
          text: text,
          fontColor: fontColor ?? Colors.white,
        ),
      ),
    );
  }
}
