part of 'receipt_bloc.dart';

sealed class ReceiptEvent extends Equatable {
  const ReceiptEvent();
}

final class GetAllReceiptIcicytaEvent extends ReceiptEvent {
  @override
  List<Object> get props => [];
}

final class GetAllReceiptIcodsaEvent extends ReceiptEvent {
  @override
  List<Object> get props => [];
}
