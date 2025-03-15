part of 'receipt_bloc.dart';

sealed class ReceiptState extends Equatable {
  const ReceiptState();
}

final class ReceiptInitial extends ReceiptState {
  @override
  List<Object> get props => [];
}
