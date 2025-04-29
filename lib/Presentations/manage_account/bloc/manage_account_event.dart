part of 'manage_account_bloc.dart';

sealed class ManageAccountEvent extends Equatable {
  const ManageAccountEvent();
}

final class LoadManageAccount extends ManageAccountEvent {
  const LoadManageAccount();

  @override
  List<Object?> get props => [];
}

class FilterAccountByRole extends ManageAccountEvent {
  final List<int> roleIds;
  FilterAccountByRole(this.roleIds);

  @override
  // TODO: implement props
  List<Object?> get props => [roleIds];
}
