import 'package:SummitDocs/Presentations/signup/bloc/signup_bloc.dart';
import 'package:SummitDocs/Presentations/signup/widgets/register_card.dart';
import 'package:SummitDocs/commons/constants/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../commons/widgets/app_scaffold.dart';
import '../../../core/config/theme/app_colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final SignupBloc _bloc = SignupBloc();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bloc: _bloc,

      /// listener used only for snackbar, dialog, navigation,etc
      listener: (BuildContext context, SignupState state) {},
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: SvgPicture.asset(
          AppString.logoApp,
          width: 45,
          height: 45,
        ),
        surfaceTintColor: Colors.white,
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
      appWidget: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: RegisterCard(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
