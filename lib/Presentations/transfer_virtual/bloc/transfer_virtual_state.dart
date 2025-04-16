part of 'transfer_virtual_bloc.dart';

sealed class TransferVirtualState extends Equatable {
  const TransferVirtualState();
}

final class TransferVirtualInitial extends TransferVirtualState {
  @override
  List<Object> get props => [];
}
