part of 'invoice_bloc.dart';

sealed class InvoiceEvent extends Equatable {
  const InvoiceEvent();
}

final class GetInvoiceIcicytaListEvent extends InvoiceEvent {
  const GetInvoiceIcicytaListEvent();

  @override
  List<Object?> get props => [];
}

final class SubmitUpdateInvoiceIcicyta extends InvoiceEvent {
  final int id;
  final String? institution;
  final String? email;
  final String? presentationType;
  final String? memberType;
  final String? authorType;
  final String? amount;
  final String? dateOfIssue;
  final int? virtualAccountId;
  final int? bankTransferId;
  final String? status;

  const SubmitUpdateInvoiceIcicyta(
      this.id,
      this.institution,
      this.email,
      this.presentationType,
      this.memberType,
      this.authorType,
      this.amount,
      this.dateOfIssue,
      this.virtualAccountId,
      this.bankTransferId,
      this.status);

  @override
  List<Object?> get props => [
        this.id,
        this.institution,
        this.email,
        this.presentationType,
        this.memberType,
        this.authorType,
        this.amount,
        this.dateOfIssue,
        this.virtualAccountId,
        this.bankTransferId,
        this.status
      ];
}

final class GetInvoiceIcodsaListEvent extends InvoiceEvent {
  const GetInvoiceIcodsaListEvent();

  @override
  List<Object?> get props => [];
}

final class SubmitUpdateInvoiceIcodsa extends InvoiceEvent {
  final int id;
  final String? institution;
  final String? email;
  final String? presentationType;
  final String? memberType;
  final String? authorType;
  final String? amount;
  final String? dateOfIssue;
  final int? virtualAccountId;
  final int? bankTransferId;
  final String? status;

  const SubmitUpdateInvoiceIcodsa(
      this.id,
      this.institution,
      this.email,
      this.presentationType,
      this.memberType,
      this.authorType,
      this.amount,
      this.dateOfIssue,
      this.virtualAccountId,
      this.bankTransferId,
      this.status);

  @override
  List<Object?> get props => [
        this.id,
        this.institution,
        this.email,
        this.presentationType,
        this.memberType,
        this.authorType,
        this.amount,
        this.dateOfIssue,
        this.virtualAccountId,
        this.bankTransferId,
        this.status
      ];
}

final class LoadVirtualAccount extends InvoiceEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class LoadTransferBankVirtual extends InvoiceEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
