import 'package:SummitDocs/core/config/theme/app_colors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppScaffold<BlocState extends Equatable, BlocEvent extends Equatable,
    BlocName extends Bloc<BlocEvent, BlocState>> extends StatelessWidget {
  final Function(BuildContext context, BlocState state) listener;
  final BlocName bloc;
  final Widget appWidget;
  final Widget? bottomAppbar;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottom;

  const AppScaffold({
    super.key,
    required this.appWidget,
    this.appBar,
    this.backgroundColor,
    required this.listener,
    required this.bloc,
    this.bottomAppbar,
    this.resizeToAvoidBottom,
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
          bottomNavigationBar: bottomAppbar,
          resizeToAvoidBottomInset: resizeToAvoidBottom,
          backgroundColor: backgroundColor ?? AppColors.secondaryBackground,
          body: SafeArea(
            child: appWidget,
          ),
        ),
      ),
    );
  }
}
