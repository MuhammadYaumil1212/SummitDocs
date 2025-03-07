import 'package:SummitDocs/commons/constants/string.dart';
import 'package:SummitDocs/commons/widgets/app_button.dart';
import 'package:SummitDocs/commons/widgets/app_text.dart';
import 'package:SummitDocs/commons/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/config/theme/app_colors.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  bool _isPasswordVisible = false;
  TextEditingController paperIdController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController conferenceTitleController = TextEditingController();
  TextEditingController writerController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController datePlaceController = TextEditingController();

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
            text: "Profil Akun",
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
          const SizedBox(height: 10),
          _buildInfoRow("Username", "Username"),
          _buildInfoRow("Email", "Email"),
          _buildInfoRow("Role", "Role"),
          _buildPasswordRow(),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: AppButton(
                action: () => _showAddDataDialog(context),
                text: "Ganti Password",
                borderColor: AppColors.grayBackground2,
                backgroundColor: AppColors.secondaryBackground,
                fontColor: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white,
          title: AppText(
            text: "Ganti Password",
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextfield(
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: AppColors.grayBackground3,
                  ),
                  obscureText: true,
                  hint: "Kata sandi lama",
                  controller: paperIdController,
                ),
                AppTextfield(
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: AppColors.grayBackground3,
                  ),
                  obscureText: true,
                  hint: "kata sandi baru",
                  controller: titleController,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: AppButton(text: "Masukkan", action: () {}),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: AppButton(
                    action: () {
                      Navigator.of(context).pop();
                    },
                    text: "Batalkan",
                    borderColor: AppColors.grayBackground2,
                    backgroundColor: AppColors.secondaryBackground,
                    fontColor: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          AppText(text: "$label :", fontWeight: FontWeight.w500),
          const SizedBox(width: 8),
          AppText(text: value),
        ],
      ),
    );
  }

  Widget _buildPasswordRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const AppText(text: "Password :", fontWeight: FontWeight.w500),
          const SizedBox(width: 8),
          AppText(text: _isPasswordVisible ? "password123" : "********"),
          const Spacer(),
          GestureDetector(
            onTap: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
            child: Icon(
              _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
