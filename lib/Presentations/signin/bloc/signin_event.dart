part of 'signin_bloc.dart';

sealed class SigninEvent extends Equatable {
  const SigninEvent();
}

class Signin extends SigninEvent {
  final String email;
  final String password;

  Signin({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
