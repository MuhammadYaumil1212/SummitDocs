part of 'signin_bloc.dart';

sealed class SigninEvent extends Equatable {
  const SigninEvent();
}

class Signin extends SigninEvent {
  final String username;
  final String password;

  Signin({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class CheckNetwork extends SigninEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NetworkStatusChanged extends SigninEvent {
  final bool connected;

  const NetworkStatusChanged({required this.connected});

  @override
  List<Object> get props => [connected];
}
