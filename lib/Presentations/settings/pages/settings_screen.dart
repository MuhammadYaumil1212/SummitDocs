import 'package:SummitDocs/Presentations/settings/widgets/ProfileCard.dart';
import 'package:flutter/material.dart';

import '../../../commons/widgets/app_text.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: "Pengaturan",
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 20),
          ProfileCard()
        ],
      ),
    );
  }
}
