part of 'home_admin_bloc.dart';

sealed class HomeAdminState extends Equatable {
  const HomeAdminState();
}

final class HomeAdminInitial extends HomeAdminState {
  @override
  List<Object> get props => [];
}

class NetworkAvailable extends HomeAdminState {
  @override
  List<Object> get props => [];
}

class NetworkUnavailable extends HomeAdminState {
  final String message;

  const NetworkUnavailable({required this.message});

  @override
  List<Object> get props => [message];
}
