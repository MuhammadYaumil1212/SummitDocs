part of 'manage_account_bloc.dart';

sealed class ManageAccountEvent extends Equatable {
  const ManageAccountEvent();
}

final class LoadManageAccount extends ManageAccountEvent {
  const LoadManageAccount();

  @override
  List<Object?> get props => [];
}

final class FilterAccountByRole extends ManageAccountEvent {
  final List<int> roleIds;
  FilterAccountByRole(this.roleIds);

  @override
  // TODO: implement props
  List<Object?> get props => [roleIds];
}

final class CreateAccount extends ManageAccountEvent {
  final String name;
  final String username;
  final String email;
  final String password;
  final String role;
  CreateAccount({
    required this.name,
    required this.username,
    required this.email,
    required this.password,
    required this.role,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [name, username, email, password, role];
}
