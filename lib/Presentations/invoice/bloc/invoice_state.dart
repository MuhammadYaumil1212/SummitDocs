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

final class SuccessTransfer extends InvoiceState {
  final List<TransferVirtualEntity> transferVirtual;
  const SuccessTransfer({required this.transferVirtual});

  @override
  List<Object> get props => [transferVirtual];
}

final class SuccessVirtualAccount extends InvoiceState {
  final List<AccountVirtualEntity> accountVirtual;
  const SuccessVirtualAccount({required this.accountVirtual});

  @override
  List<Object> get props => [accountVirtual];
}

final class FailedState extends InvoiceState {
  final String message;

  const FailedState(this.message);

  @override
  List<Object> get props => [message];
}

final class UpdateInvoiceIcicytaState extends InvoiceState {
  final String message;

  const UpdateInvoiceIcicytaState(this.message);

  @override
  List<Object> get props => [message];
}

final class UpdateInvoiceIcicytaLoadingState extends InvoiceState {
  final bool isLoading;

  const UpdateInvoiceIcicytaLoadingState(this.isLoading);

  @override
  List<Object> get props => [isLoading];
}

final class FailedUpdateInvoiceIcicyta extends InvoiceState {
  final List<String> message;

  const FailedUpdateInvoiceIcicyta(this.message);

  @override
  List<Object> get props => [message];
}

final class SuccessUpdateInvoiceIcicyta extends InvoiceState {
  final String message;

  const SuccessUpdateInvoiceIcicyta(this.message);
  @override
  List<Object> get props => [message];
}

final class FailedUpdateInvoiceIcodsa extends InvoiceState {
  final List<String> message;

  const FailedUpdateInvoiceIcodsa(this.message);

  @override
  List<Object> get props => [message];
}

final class SuccessUpdateInvoiceIcodsa extends InvoiceState {
  final String message;

  const SuccessUpdateInvoiceIcodsa(this.message);

  @override
  List<Object> get props => [message];
}

final class UpdateInvoiceIcodsaLoadingState extends InvoiceState {
  final bool isLoading;

  const UpdateInvoiceIcodsaLoadingState({required this.isLoading});

  @override
  List<Object> get props => [isLoading];
}
