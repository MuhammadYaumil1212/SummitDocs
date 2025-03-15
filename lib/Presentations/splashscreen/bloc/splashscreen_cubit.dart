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
    final role = await storageInstance.get<int>(AppString.ROLE);
    if (storage != null) {
      switch (role) {
        case 1:
          emit(SuperAdmin());
          break;
        case 2:
          emit(Icodsa());
          break;
        case 3:
          emit(Icicyta());
          break;
        default:
          emit(UnAuthenticated());
      }
    } else {
      emit(UnAuthenticated());
    }
  }
}
