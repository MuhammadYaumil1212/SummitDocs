part of 'settings_bloc.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();
}

final class SettingsInitial extends SettingsState {
  @override
  List<Object> get props => [];
}

final class LoadingState extends SettingsState {
  final bool isLoading;
  const LoadingState({this.isLoading = false});
  @override
  List<Object> get props => [isLoading];
}

final class ErrorState extends SettingsState {
  final List<String> errorMessage;
  const ErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

final class SuccessState extends SettingsState {
  final String message;
  const SuccessState({required this.message});
  @override
  List<Object> get props => [message];
}
