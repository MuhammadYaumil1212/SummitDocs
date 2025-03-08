import 'package:flutter/material.dart';

import '../../../commons/widgets/app_text.dart';
import '../../../core/config/theme/app_colors.dart';

class PasswordRulesWidget extends StatelessWidget {
  const PasswordRulesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final rules = [
      '• Minimal 8 karakter',
      '• Setidaknya satu huruf besar',
      '• Setidaknya satu angka',
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rules
            .map(
              (rule) => AppText(
                text: rule,
                fontColor: AppColors.grayBackground4,
              ),
            )
            .toList(),
      ),
    );
  }
}
