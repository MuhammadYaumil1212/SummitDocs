part of 'invoice_bloc.dart';

sealed class InvoiceState extends Equatable {
  const InvoiceState();
}

final class InvoiceInitial extends InvoiceState {
  @override
  List<Object> get props => [];
}
