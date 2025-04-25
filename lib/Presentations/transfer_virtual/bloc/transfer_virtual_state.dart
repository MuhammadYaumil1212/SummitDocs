part of 'transfer_virtual_bloc.dart';

sealed class TransferVirtualState extends Equatable {
  const TransferVirtualState();
}

final class TransferVirtualInitial extends TransferVirtualState {
  @override
  List<Object> get props => [];
}

final class LoadingTransfer extends TransferVirtualState {
  final bool isLoading;
  LoadingTransfer({required this.isLoading});

  @override
  List<Object> get props => [isLoading];
}

final class SuccessTransfer extends TransferVirtualState {
  final List<TransferVirtualEntity> transferVirtual;
  const SuccessTransfer({required this.transferVirtual});

  @override
  List<Object> get props => [transferVirtual];
}

final class FailedTransfer extends TransferVirtualState {
  final String errorMessage;
  const FailedTransfer({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

final class FailedSendData extends TransferVirtualState {
  final List<String> errorMessage;

  const FailedSendData({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

final class SuccessSendData extends TransferVirtualState {
  final String successMessage;
  SuccessSendData({required this.successMessage});
  @override
  // TODO: implement props
  List<Object?> get props => [successMessage];
}
