import 'package:SummitDocs/Data/home/models/invoice_model.dart';
import 'package:SummitDocs/Domain/home/entities/invoice_entity.dart';

class InvoiceIcodsaMapper {
  static InvoiceEntity toEntity(InvoiceModel invoiceModel) {
    return InvoiceEntity(
      id: invoiceModel.id,
      email: invoiceModel.email,
      status: invoiceModel.status,
      amount: invoiceModel.amount,
      dateOfIssue: invoiceModel.dateOfIssue,
      institution: invoiceModel.institution,
      invoiceNo: invoiceModel.invoiceNo,
      loaId: invoiceModel.loaId,
      presentationType: invoiceModel.presentationType,
      memberType: invoiceModel.memberType,
      authorType: invoiceModel.authorType,
      signatureId: invoiceModel.signatureId,
      virtualAccountId: invoiceModel.virtualAccountId,
      bankTransferId: invoiceModel.bankTransferId,
      createdBy: invoiceModel.createdBy,
    );
  }
}

///
///  final int paperId;
//   final String paperTitle;
//   final String conferenceTitle;
//   final String writer;
//   final String time;
//   final String dateAndPlace;
//   final String status;
///
///
///
