import 'package:SummitDocs/Domain/home/entities/invoice_entity.dart';

import '../../../Data/home/models/invoice_model.dart';

class InvoiceMapper {
  static InvoiceEntity toEntity(InvoiceModel entity) {
    return InvoiceEntity(
      id: entity.id,
      invoiceNo: entity.invoiceNo,
      bankTransferId: entity.bankTransferId,
      dateOfIssue: entity.dateOfIssue,
      institution: entity.institution,
      loaId: entity.loaId,
      memberType: entity.memberType,
      presentationType: entity.presentationType,
      virtualAccountId: entity.virtualAccountId,
      authorType: entity.authorType,
      email: entity.email,
      signatureId: entity.signatureId,
      amount: entity.amount,
      status: entity.status,
      createdBy: entity.createdBy,
    );
  }
}
