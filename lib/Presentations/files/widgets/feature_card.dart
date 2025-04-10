import 'package:SummitDocs/commons/widgets/app_text.dart';
import 'package:SummitDocs/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Featurecard extends StatelessWidget {
  final VoidCallback onClick;
  final String icon;
  final String text;
  final double? sizeHeightBox;
  final double? sizeWidthBox;
  final double? iconSize;
  final double? textSize;
  Featurecard({
    super.key,
    required this.onClick,
    required this.icon,
    required this.text,
    this.sizeHeightBox,
    this.sizeWidthBox,
    this.iconSize,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: sizeWidthBox ?? MediaQuery.of(context).size.width * 0.25,
        height: sizeHeightBox ?? MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            color: AppColors.background,
            border: Border.all(color: AppColors.grayBackground2)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
                width: iconSize ?? 30,
                height: iconSize ?? 30,
              ),
              const SizedBox(height: 5),
              AppText(
                text: text,
                fontSize: textSize,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
