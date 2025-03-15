part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

class CheckNetwork extends HomeEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NetworkStatusChanged extends HomeEvent {
  final bool connected;

  const NetworkStatusChanged({required this.connected});

  @override
  List<Object> get props => [connected];
}
