import 'package:SummitDocs/Presentations/home_admin/pages/icicyta/home_icycita_screen.dart';
import 'package:SummitDocs/Presentations/home_admin/pages/icodsa/home_icodsa_screen.dart';
import 'package:SummitDocs/Presentations/home_super_admin/pages/home_screen.dart';
import 'package:SummitDocs/commons/constants/string.dart';
import 'package:SummitDocs/core/helper/message/message.dart';
import 'package:SummitDocs/core/helper/navigation/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../commons/widgets/app_button.dart';
import '../../../commons/widgets/app_scaffold.dart';
import '../../../commons/widgets/app_text.dart';
import '../../../commons/widgets/app_textfield.dart';
import '../../../core/config/theme/app_colors.dart';
import '../../../core/helper/storage/AppStorage.dart';
import '../bloc/signin_bloc.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _bloc = SigninBloc();
  late final TextEditingController _username;
  late final TextEditingController _password;
  late final AppStorage _storage;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.add(CheckNetwork());
    _username = TextEditingController();
    _password = TextEditingController();
    initStorage();
  }

  void initStorage() async {
    _storage = await AppStorage.instance;
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  void _validateAndLogin() {
    if (_formKey.currentState!.validate()) {
      _bloc.add(
        Signin(
          username: _username.text,
          password: _password.text,
        ),
      );
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
    return AppScaffold(
      bloc: _bloc,

      /// listener used only for snackbar, dialog, navigation,etc
      listener: (BuildContext context, SigninState state) {
        if (state is NetworkUnavailable) {
          return DisplayMessage.errorMessage(state.message, context);
        }
        if (state is OnFailed) {
          return DisplayMessage.errorMessage(state.errorMessage, context);
        }
        if (state is OnSuccess) {
          switch (state.signinEntity.role) {
            case 1:
              return AppNavigator.pushAndRemove(context, HomeScreen());
            case 2:
              return AppNavigator.pushAndRemove(context, HomeIcodsaScreen());
            case 3:
              return AppNavigator.pushAndRemove(context, HomeIcycitaScreen());
            default:
              return DisplayMessage.errorMessage("Account Not Found", context);
          }
        }
      },
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: SvgPicture.asset(
          AppString.logoApp,
          width: 45,
          height: 45,
        ),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: AppColors.grayBackground,
            height: 4.0,
          ),
        ),
      ),

      /// Use bloc builder if you wanna used the state
      appWidget: BlocBuilder<SigninBloc, SigninState>(
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
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
                            AppButton(
                              text: "Login",
                              action: _validateAndLogin,
                              isLoading: state is OnLoading && state.isLoading,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
