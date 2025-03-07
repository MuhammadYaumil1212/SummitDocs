import 'package:SummitDocs/Presentations/settings/widgets/ProfileCard.dart';
import 'package:SummitDocs/commons/widgets/app_button.dart';
import 'package:SummitDocs/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../commons/widgets/app_text.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: "Pengaturan",
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: 20),
            ProfileCard(),
            const SizedBox(height: 20),
            AppButton(
              text: "Logout",
              action: () {},
              backgroundColor: Colors.white,
              iconColor: Colors.redAccent,
              borderColor: AppColors.grayBackground2,
              icon: Icons.logout,
              fontColor: AppColors.redFailed,
              fontWeight: FontWeight.w400,
            )
          ],
        ),
      ),
    );
  }
}
