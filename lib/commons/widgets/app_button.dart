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
  final IconData? icon;
  final Color? iconColor;

  const AppButton(
      {super.key,
      required this.text,
      required this.action,
      this.fontColor,
      this.backgroundColor,
      this.borderColor,
      this.fontWeight,
      this.iconColor,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: action,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        side: BorderSide(color: borderColor ?? Colors.transparent),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: icon != ""
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: iconColor,
                ),
                const SizedBox(width: 5),
                AppText(
                  text: text,
                  fontWeight: fontWeight ?? FontWeight.w700,
                  fontColor: fontColor ?? Colors.white,
                ),
              ],
            )
          : Center(
              child: AppText(
                text: text,
                fontWeight: fontWeight ?? FontWeight.w700,
                fontColor: fontColor ?? Colors.white,
              ),
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

class FileAddButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;

  const FileAddButton({
    Key? key,
    this.text = "Tambah Data",
    required this.onTap,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.35,
        height: MediaQuery.of(context).size.width * 0.10,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
