import 'package:SummitDocs/Presentations/signin/pages/signin_screen.dart';
import 'package:SummitDocs/Presentations/signup/pages/signup_screen.dart';
import 'package:SummitDocs/commons/constants/string.dart';
import 'package:SummitDocs/commons/widgets/app_button.dart';
import 'package:SummitDocs/commons/widgets/app_text.dart';
import 'package:SummitDocs/commons/widgets/app_textfield.dart';
import 'package:SummitDocs/core/helper/navigation/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/config/theme/app_colors.dart';
import 'bullet_text.dart';

class RegisterCard extends StatefulWidget {
  const RegisterCard({super.key});

  @override
  State<RegisterCard> createState() => _RegisterCardState();
}

class _RegisterCardState extends State<RegisterCard> {
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
            text: "Register",
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
          const AppText(
            text: "Daftar Akun",
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          const SizedBox(height: 20),
          AppTextfield(
            hint: "Masukkan Email",
            controller: TextEditingController(),
            prefixIcon: Icon(
              Icons.person_outline,
              color: AppColors.grayBackground3,
            ),
          ),
          AppTextfield(
            hint: "Konfirmasi ulang Email",
            controller: TextEditingController(),
            prefixIcon: Icon(
              Icons.person_outline,
              color: AppColors.grayBackground3,
            ),
          ),
          AppTextfield(
            hint: "Masukkan username",
            controller: TextEditingController(),
            prefixIcon: Icon(
              Icons.person_outline,
              color: AppColors.grayBackground3,
            ),
          ),
          AppTextfield(
            hint: "Kata Sandi Baru",
            controller: TextEditingController(),
            obscureText: true,
            prefixIcon: Icon(
              Icons.lock_outline,
              color: AppColors.grayBackground3,
            ),
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 15,
                color: AppColors.grayBackground4,
              ),
              children: [
                const TextSpan(
                  text: '*',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(
                  text: 'Syarat kata sandi:\n',
                ),
                WidgetSpan(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        AppText(
                          text: '• Minimal 8 karakter',
                          fontColor: AppColors.grayBackground4,
                        ),
                        AppText(
                          text: '• Setidaknya satu huruf besar',
                          fontColor: AppColors.grayBackground4,
                        ),
                        AppText(
                          text: '• Setidaknya satu angka',
                          fontColor: AppColors.grayBackground4,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          AppTextfield(
            hint: "Konfirmasi Kata Sandi Baru",
            controller: TextEditingController(),
            obscureText: true,
            prefixIcon: Icon(
              Icons.lock_outline,
              color: AppColors.grayBackground3,
            ),
          ),
          const SizedBox(height: 20),
          AppButton(text: "Register", action: () {}),
          AppButton(
            action: () {
              AppNavigator.pushAndRemove(
                context,
                SigninScreen(),
                transitionType: TransitionType.fade,
              );
            },
            text: "atau Login",
            backgroundColor: AppColors.background,
            fontColor: Colors.black,
            fontWeight: FontWeight.w400,
            borderColor: AppColors.grayBackground3,
          )
        ],
      ),
    );
  }
}
