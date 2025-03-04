import 'package:SummitDocs/commons/widgets/app_button.dart';
import 'package:SummitDocs/core/helper/message/message.dart';
import 'package:flutter/material.dart';

import '../../../commons/widgets/app_scaffold.dart';
import '../../../commons/widgets/app_text.dart';
import '../bloc/signin_bloc.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _bloc = SigninBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.add(CheckNetwork());
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
      },

      /// Use bloc builder if you wanna used the state
      appWidget: Column(
        children: [
          AppButton(
              text: "Login",
              action: () {
                print("Clicked");
              })
        ],
      ),
    );
  }
}
