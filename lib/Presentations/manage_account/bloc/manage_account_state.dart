part of 'manage_account_bloc.dart';

sealed class ManageAccountState extends Equatable {
  const ManageAccountState();
}

final class ManageAccountInitial extends ManageAccountState {
  @override
  List<Object> get props => [];
}
