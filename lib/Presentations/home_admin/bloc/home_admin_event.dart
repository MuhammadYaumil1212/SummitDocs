part of 'home_admin_bloc.dart';

sealed class HomeAdminEvent extends Equatable {
  const HomeAdminEvent();
}

class CheckNetwork extends HomeAdminEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NetworkStatusChanged extends HomeAdminEvent {
  final bool connected;

  const NetworkStatusChanged({required this.connected});

  @override
  List<Object> get props => [connected];
}
