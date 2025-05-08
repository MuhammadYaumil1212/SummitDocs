part of 'invoice_bloc.dart';

sealed class InvoiceEvent extends Equatable {
  const InvoiceEvent();
}

final class GetInvoiceIcicytaListEvent extends InvoiceEvent {
  const GetInvoiceIcicytaListEvent();

  @override
  List<Object?> get props => [];
}
