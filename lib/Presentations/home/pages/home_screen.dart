import 'package:berkas_conference/commons/widgets/app_scaffold.dart';
import 'package:berkas_conference/commons/widgets/reactive_button/app_button.dart';
import 'package:berkas_conference/core/helper/message/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc _bloc = HomeBloc();

  @override
  void initState() {
    // TODO: implement initState
    _bloc.add(CheckNetwork());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bloc: _bloc,

      /// listener used only for snackbar, dialog, navigation,etc
      listener: (BuildContext context, HomeState state) {
        if (state is NetworkUnavailable) {
          DisplayMessage.errorMessage(state.message, context);
        }
      },

      /// Use bloc builder if you wanna used the state
      appWidget: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is NetworkAvailable) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Center(child: Text("Available"))],
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Center(child: Text("Unavailable"))],
            );
          }
        },
      ),
    );
  }
}
