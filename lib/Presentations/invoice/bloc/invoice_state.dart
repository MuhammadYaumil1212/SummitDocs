part of 'invoice_bloc.dart';

sealed class InvoiceState extends Equatable {
  const InvoiceState();
}

final class InvoiceInitial extends InvoiceState {
  @override
  List<Object> get props => [];
}

final class LoadingState extends InvoiceState {
  final bool isLoading;
  LoadingState({required this.isLoading});

  @override
  List<Object> get props => [isLoading];
}

final class SuccessState extends InvoiceState {
  final List<InvoiceEntity> data;

  const SuccessState(this.data);

  @override
  List<Object> get props => [data];
}

final class FailedState extends InvoiceState {
  final String message;

  const FailedState(this.message);

  @override
  List<Object> get props => [message];
}
