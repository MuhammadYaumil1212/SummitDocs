import 'package:berkas_conference/core/network/network_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:meta/meta.dart';

import '../../../commons/constants/string.dart';
import '../../../core/helper/storage/AppStorage.dart';

part 'splashscreen_state.dart';

class SplashscreenCubit extends Cubit<SplashscreenState> {
  SplashscreenCubit() : super(SplashscreenInitial());

  void appStarted() async {
    final storageInstance = AppStorage.instance;
    await Future.delayed(Duration(seconds: 2));
    final storage = await storageInstance.get(AppString.TOKEN_KEY);
    if (storage != null) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }
}
