import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../Data/signin/models/signinParams.dart';
import '../../../Domain/signin/usecases/signin_usecase.dart';
import '../../../service_locator.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(SigninInitial()) {
    on<SigninEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<Signin>((event, emit) async {
      var signinCall = await sl<SigninUsecase>().call(
        params: SigninParams(email: event.email, password: event.password),
      );
      signinCall.fold((error) {
        emit(OnFailed(errorMessage: error));
      }, (_) {
        emit(OnSuccess());
      });
    });
  }
}
