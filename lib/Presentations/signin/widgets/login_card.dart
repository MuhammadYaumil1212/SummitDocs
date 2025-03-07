import 'package:SummitDocs/commons/constants/string.dart';
import 'package:SummitDocs/commons/widgets/app_button.dart';
import 'package:SummitDocs/commons/widgets/app_text.dart';
import 'package:SummitDocs/commons/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/config/theme/app_colors.dart';

class LoginCard extends StatefulWidget {
  const LoginCard({super.key});

  @override
  State<LoginCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<LoginCard> {
  TextEditingController paperIdController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(
            text: "Login",
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
          const AppText(
            text: "Login dengan akun yang ada",
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppTextfield(
                hint: "username",
                controller: TextEditingController(),
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: AppColors.grayBackground3,
                ),
              ),
              AppTextfield(
                hint: "Password",
                controller: TextEditingController(),
                obscureText: true,
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: AppColors.grayBackground3,
                ),
              ),
              AppText(
                text: "Lupa Kata Sandi ?",
                fontColor: AppColors.grayBackground3,
              )
            ],
          ),
          const SizedBox(height: 20),
          AppButton(text: "Login", action: () {})
        ],
      ),
    );
  }
}
