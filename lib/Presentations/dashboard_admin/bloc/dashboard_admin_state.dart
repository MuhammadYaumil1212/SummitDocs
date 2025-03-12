part of 'dashboard_admin_bloc.dart';

sealed class DashboardAdminState extends Equatable {
  const DashboardAdminState();
}

final class DashboardAdminInitial extends DashboardAdminState {
  @override
  List<Object> get props => [];
}
