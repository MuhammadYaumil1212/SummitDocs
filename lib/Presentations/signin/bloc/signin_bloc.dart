import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../Data/signin/models/signinParams.dart';
import '../../../Domain/signin/usecases/signin_usecase.dart';
import '../../../core/network/network_cubit.dart';
import '../../../service_locator.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final NetworkCubit internetCubit = NetworkCubit();
  SigninBloc() : super(SigninInitial()) {
    on<SigninEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<CheckNetwork>((event, emit) {
      internetCubit.stream.listen((status) {
        if (status == InternetConnectionStatus.connected) {
          add(NetworkStatusChanged(connected: true));
        } else {
          add(NetworkStatusChanged(connected: false));
        }
      });
    });

    on<NetworkStatusChanged>((event, emit) {
      if (event.connected) {
        emit(NetworkAvailable());
      } else {
        emit(NetworkUnavailable(message: 'Koneksi Terputus'));
      }
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
