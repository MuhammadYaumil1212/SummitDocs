part of 'signin_bloc.dart';

sealed class SigninState extends Equatable {
  const SigninState();
}

final class SigninInitial extends SigninState {
  @override
  List<Object> get props => [];
}

final class OnLoading extends SigninState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class OnFailed extends SigninState {
  final String errorMessage;
  const OnFailed({required this.errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}

final class OnSuccess extends SigninState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
