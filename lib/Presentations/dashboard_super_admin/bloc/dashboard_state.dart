part of 'dashboard_bloc.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();
}

final class DashboardInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

final class LoadingDashboard extends DashboardEvent {
  @override
  List<Object?> get props => [];
}

final class SuccessDashboard extends DashboardEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class FailedDashboard extends DashboardEvent {
  final String errorMessage;
  FailedDashboard({required this.errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
