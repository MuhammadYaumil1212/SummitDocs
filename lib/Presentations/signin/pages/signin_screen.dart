import 'package:berkas_conference/Presentations/signin/bloc/signin_bloc.dart';
import 'package:berkas_conference/commons/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

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
        children: [Text("Signin Screen")],
      ),
    );
  }
}
