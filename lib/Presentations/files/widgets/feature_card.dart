import 'package:SummitDocs/commons/widgets/app_text.dart';
import 'package:SummitDocs/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Featurecard extends StatelessWidget {
  final VoidCallback onClick;
  final String icon;
  final String text;
  const Featurecard({
    super.key,
    required this.onClick,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: 110,
        height: 80,
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
                width: 30,
                height: 30,
              ),
              const SizedBox(height: 5),
              AppText(text: text)
            ],
          ),
        ),
      ),
    );
  }
}
