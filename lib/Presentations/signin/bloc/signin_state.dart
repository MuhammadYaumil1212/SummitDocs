part of 'signin_bloc.dart';

sealed class SigninState extends Equatable {
  const SigninState();
}

final class SigninInitial extends SigninState {
  @override
  List<Object> get props => [];
}

final class OnLoading extends SigninState {
  final bool isLoading;
  OnLoading({this.isLoading = false});
  @override
  // TODO: implement propss
  List<Object?> get props => [isLoading];
}

final class OnFailed extends SigninState {
  final String errorMessage;
  const OnFailed({required this.errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}

final class OnSuccess extends SigninState {
  SigninEntity signinEntity;
  OnSuccess({required this.signinEntity});
  @override
  // TODO: implement props
  List<Object?> get props => [signinEntity];
}

class NetworkAvailable extends SigninState {
  @override
  List<Object> get props => [];
}

class NetworkUnavailable extends SigninState {
  final String message;

  const NetworkUnavailable({required this.message});

  @override
  List<Object> get props => [message];
}
