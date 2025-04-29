part of 'manage_account_bloc.dart';

sealed class ManageAccountState extends Equatable {
  const ManageAccountState();
}

final class ManageAccountInitial extends ManageAccountState {
  @override
  List<Object> get props => [];
}

final class LoadingTable extends ManageAccountState {
  final bool isLoading;
  LoadingTable({required this.isLoading});

  @override
  // TODO: implement props
  List<Object?> get props => [isLoading];
}

final class FailedTable extends ManageAccountState {
  final String errorMessage;
  FailedTable({required this.errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}

final class TableLoaded extends ManageAccountState {
  final List<UserEntity> userList;
  TableLoaded({required this.userList});

  @override
  // TODO: implement props
  List<Object?> get props => [userList];
}
