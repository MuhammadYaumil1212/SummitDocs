import 'package:SummitDocs/Presentations/settings/widgets/ProfileCard.dart';
import 'package:SummitDocs/Presentations/signin/pages/signin_screen.dart';
import 'package:SummitDocs/commons/widgets/app_button.dart';
import 'package:SummitDocs/core/config/theme/app_colors.dart';
import 'package:SummitDocs/core/helper/navigation/app_navigation.dart';
import 'package:flutter/material.dart';

import '../../../commons/constants/string.dart';
import '../../../commons/widgets/app_text.dart';
import '../../../core/helper/storage/AppStorage.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final AppStorage? storage;

  @override
  void initState() {
    // TODO: implement initState
    initStorage();
    super.initState();
  }

  void initStorage() async {
    storage = await AppStorage.instance;
  }

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
              action: () {
                storage?.delete(AppString.TOKEN_KEY);
                storage?.delete(AppString.ROLE);
                AppNavigator.pushAndRemove(context, SigninScreen());
              },
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
