import 'package:SummitDocs/commons/constants/string.dart';
import 'package:SummitDocs/commons/widgets/app_text.dart';
import 'package:SummitDocs/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StatusFile extends StatelessWidget {
  final String statusText;
  final bool status;

  const StatusFile({
    super.key,
    required this.statusText,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          status ? AppString.icSuccess : AppString.icfailed,
          width: 16,
          height: 16,
        ),
        const SizedBox(width: 8),
        AppText(
          text: statusText,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontColor: status ? AppColors.greenSuccess : AppColors.redFailed,
        ),
        !status
            ? const SizedBox(width: 5.7)
            : const SizedBox(
                width: 0,
              )
      ],
    );
  }
}
