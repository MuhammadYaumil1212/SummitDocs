import 'package:SummitDocs/commons/widgets/app_text.dart';
import 'package:SummitDocs/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback action;
  final Color? fontColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final FontWeight? fontWeight;

  const AppButton({
    super.key,
    required this.text,
    required this.action,
    this.fontColor,
    this.backgroundColor,
    this.borderColor,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: action,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        side: BorderSide(color: borderColor ?? Colors.transparent),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: AppText(
        text: text,
        fontWeight: fontWeight ?? FontWeight.w700,
        fontColor: fontColor ?? Colors.white,
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String icon;
  final VoidCallback action;
  final Color? fontColor;
  final Color? backgroundColor;
  final Color? borderColor;
  const ActionButton({
    super.key,
    required this.icon,
    required this.action,
    this.fontColor,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            icon,
            width: 20,
            height: 20,
          ),
        ),
      ),
    );
  }
}
