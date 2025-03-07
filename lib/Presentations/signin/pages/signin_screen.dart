import 'package:SummitDocs/Presentations/signin/widgets/login_card.dart';
import 'package:SummitDocs/commons/constants/string.dart';
import 'package:SummitDocs/core/helper/message/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../commons/widgets/app_scaffold.dart';
import '../../../core/config/theme/app_colors.dart';
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
      appWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: LoginCard(),
            ),
          )
        ],
      ),
    );
  }
}
