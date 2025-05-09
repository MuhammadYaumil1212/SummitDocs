part of 'receipt_bloc.dart';

sealed class ReceiptState extends Equatable {
  const ReceiptState();
}

final class ReceiptInitial extends ReceiptState {
  @override
  List<Object> get props => [];
}

final class LoadingState extends ReceiptState {
  final bool isLoading;
  LoadingState(this.isLoading);
  @override
  List<Object> get props => [isLoading];
}

final class FailedTable extends ReceiptState {
  final String message;
  FailedTable(this.message);
  @override
  List<Object> get props => [message];
}

final class SuccessTable extends ReceiptState {
  final List<ReceiptEntity> data;
  SuccessTable(this.data);
  @override
  List<Object> get props => [data];
}
