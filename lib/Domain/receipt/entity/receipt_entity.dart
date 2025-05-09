class ReceiptEntity {
  int? id;
  String? invoiceNo;
  String? receivedFrom;
  String? amount;
  String? inPaymentOf;
  String? paymentDate;
  String? paperId;
  String? paperTitle;
  int? signatureId;
  int? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  ReceiptEntity({
    this.id,
    this.invoiceNo,
    this.receivedFrom,
    this.amount,
    this.inPaymentOf,
    this.paymentDate,
    this.paperId,
    this.paperTitle,
    this.signatureId,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });
}
