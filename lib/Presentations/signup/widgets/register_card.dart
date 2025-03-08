import 'package:flutter/material.dart';
import 'package:SummitDocs/Presentations/signin/pages/signin_screen.dart';
import 'package:SummitDocs/commons/widgets/app_button.dart';
import 'package:SummitDocs/commons/widgets/app_text.dart';
import 'package:SummitDocs/commons/widgets/app_textfield.dart';
import 'package:SummitDocs/core/helper/navigation/app_navigation.dart';
import '../../../core/config/theme/app_colors.dart';

class RegisterCard extends StatefulWidget {
  const RegisterCard({super.key});

  @override
  State<RegisterCard> createState() => _RegisterCardState();
}

class _RegisterCardState extends State<RegisterCard> {
  late final TextEditingController _email;
  late final TextEditingController _confirmEmail;
  late final TextEditingController _username;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _confirmEmail = TextEditingController();
    _username = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _confirmEmail.dispose();
    _username.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  void _validateAndRegister() {
    if (_formKey.currentState!.validate()) {
      print("Register berhasil");
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
                text: "Register", fontWeight: FontWeight.w700, fontSize: 18),
            const AppText(
                text: "Daftar Akun", fontWeight: FontWeight.w400, fontSize: 16),
            const SizedBox(height: 20),
            _buildTextField("Masukkan Email", _email, Icons.person_outline),
            _buildTextField(
                "Konfirmasi ulang Email", _confirmEmail, Icons.person_outline),
            _buildTextField(
                "Masukkan username", _username, Icons.person_outline),
            _buildTextField("Kata Sandi Baru", _password, Icons.lock_outline,
                obscureText: true),
            const PasswordRulesWidget(),
            _buildTextField("Konfirmasi Kata Sandi Baru", _confirmPassword,
                Icons.lock_outline,
                obscureText: true),
            const SizedBox(height: 20),
            AppButton(text: "Register", action: _validateAndRegister),
            AppButton(
              action: () {
                AppNavigator.pushAndRemove(
                  context,
                  SigninScreen(),
                  slideType: SlideType.left,
                );
              },
              text: "atau Login",
              backgroundColor: AppColors.background,
              fontColor: Colors.black,
              fontWeight: FontWeight.w400,
              borderColor: AppColors.grayBackground3,
            ),
          ],
        ),
      ),
    );
  }
}

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
            .map((rule) =>
                AppText(text: rule, fontColor: AppColors.grayBackground4))
            .toList(),
      ),
    );
  }
}
