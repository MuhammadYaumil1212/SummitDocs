import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppScaffold<BlocState extends Equatable, BlocEvent extends Equatable,
    BlocName extends Bloc<BlocEvent, BlocState>> extends StatelessWidget {
  final Widget appWidget;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final Function(BuildContext context, BlocState state) listener;
  final BlocName bloc;

  const AppScaffold({
    super.key,
    required this.appWidget,
    this.appBar,
    this.backgroundColor,
    required this.listener,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocListener<BlocName, BlocState>(
        listener: listener,
        bloc: bloc,
        child: Scaffold(
          appBar: appBar,
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: appWidget,
          ),
        ),
      ),
    );
  }
}
