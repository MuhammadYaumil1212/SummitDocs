import 'package:flutter/material.dart';
import 'package:SummitDocs/commons/widgets/app_button.dart';
import 'package:SummitDocs/commons/widgets/app_text.dart';
import 'package:SummitDocs/commons/widgets/app_textfield.dart';
import '../../../core/config/theme/app_colors.dart';

class LoginCard extends StatefulWidget {
  const LoginCard({super.key});

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  late final TextEditingController _username;
  late final TextEditingController _password;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _username = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  void _validateAndLogin() {
    if (_formKey.currentState!.validate()) {
    } else {
      print("Validasi gagal");
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  Widget _buildTextField(
      String hint, TextEditingController controller, IconData icon,
      {bool obscureText = false}) {
    return AppTextfield(
      hint: hint,
      controller: controller,
      obscureText: obscureText,
      prefixIcon: Icon(icon, color: AppColors.grayBackground3),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$hint tidak boleh kosong';
        }
        if (hint == "Username" && value.length < 4) {
          return 'Username minimal 4 karakter';
        }
        if (hint == "Password") {
          if (value.length < 8) {
            return 'Password minimal 8 karakter';
          }
          if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
            return 'Password harus mengandung setidaknya satu huruf besar';
          }
          if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
            return 'Password harus mengandung setidaknya satu angka';
          }
        }
        return null;
      },
    );
  }

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
      child: Form(
        key: _formKey,
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
                fontSize: 16),
            const SizedBox(height: 20),
            _buildTextField(
              "Username",
              _username,
              Icons.person_outline,
            ),
            _buildTextField(
              "Password",
              _password,
              Icons.lock_outline,
              obscureText: true,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: AppText(
                text: "Lupa Kata Sandi ?",
                fontColor: AppColors.grayBackground3,
              ),
            ),
            const SizedBox(height: 20),
            AppButton(text: "Login", action: _validateAndLogin),
          ],
        ),
      ),
    );
  }
}
