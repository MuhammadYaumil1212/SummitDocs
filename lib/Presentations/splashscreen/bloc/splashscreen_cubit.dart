import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
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
    final getRole = await storageInstance.get<bool>(AppString.is_superAdmin);
    if (storage != null) {
      if (getRole == true) {
        emit(IsSuperAdmin());
      } else {
        emit(Authenticated());
      }
    } else {
      emit(UnAuthenticated());
    }
  }
}
