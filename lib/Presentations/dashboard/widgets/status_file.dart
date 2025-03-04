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
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: SvgPicture.asset(
              status ? AppString.icSuccess : AppString.icfailed,
              width: 16,
              height: 16,
            ),
          ),
          SizedBox(width: !status ? 9 : 4),
          AppText(
            text: statusText,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontColor: status ? AppColors.greenSuccess : AppColors.redFailed,
          ),
        ],
      ),
    );
  }
}
