class InvoiceEntity {
  int? id;
  String? invoiceNo;
  int? loaId;
  String? institution;
  String? email;
  String? presentationType;
  String? memberType;
  String? authorType;
  String? amount;
  String? dateOfIssue;
  int? signatureId;
  int? virtualAccountId;
  int? bankTransferId;
  int? createdBy;
  String? status;
  DateTime? createdAt;

  InvoiceEntity({
    this.id,
    this.invoiceNo,
    this.loaId,
    this.institution,
    this.email,
    this.presentationType,
    this.memberType,
    this.authorType,
    this.amount,
    this.dateOfIssue,
    this.signatureId,
    this.virtualAccountId,
    this.bankTransferId,
    this.createdBy,
    this.status,
    this.createdAt,
  });
}
