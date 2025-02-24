part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
}

final class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class NetworkAvailable extends HomeState {
  @override
  List<Object> get props => [];
}

class NetworkUnavailable extends HomeState {
  final String message;

  const NetworkUnavailable({required this.message});

  @override
  List<Object> get props => [message];
}
