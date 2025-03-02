import 'package:flutter/material.dart';

import '../../../commons/widgets/app_scaffold.dart';
import '../../../commons/widgets/app_text.dart';
import '../bloc/signin_bloc.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bloc: SigninBloc(),

      /// listener used only for snackbar, dialog, navigation,etc
      listener: (BuildContext context, SigninState state) {},

      /// Use bloc builder if you wanna used the state
      appWidget: Column(
        children: [
          AppText(text: "Signin"),
        ],
      ),
    );
  }
}
