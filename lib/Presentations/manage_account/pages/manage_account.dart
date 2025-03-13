import 'package:SummitDocs/Presentations/manage_account/bloc/manage_account_bloc.dart';
import 'package:SummitDocs/commons/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class ManageAccount extends StatelessWidget {
  const ManageAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final ManageAccountBloc _bloc = ManageAccountBloc();
    return AppScaffold(
      bloc: _bloc,
      listener: (BuildContext context, ManageAccountState state) {},
      appWidget: Column(
        children: [],
      ),
    );
  }
}
