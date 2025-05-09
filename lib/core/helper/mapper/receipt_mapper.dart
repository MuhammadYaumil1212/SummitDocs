import 'package:SummitDocs/Domain/receipt/entity/receipt_entity.dart';

import '../../../Data/receipt/models/receipt_model.dart';

class ReceiptMapper {
  static ReceiptEntity toEntity(ReceiptModel model) {
    return ReceiptEntity(
        id: model.id,
        paperId: model.paperId,
        amount: model.amount,
        inPaymentOf: model.inPaymentOf,
        invoiceNo: model.invoiceNo,
        paperTitle: model.paperTitle,
        paymentDate: model.paymentDate,
        signatureId: model.signatureId,
        receivedFrom: model.receivedFrom,
        createdBy: model.createdBy,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt);
  }
}
