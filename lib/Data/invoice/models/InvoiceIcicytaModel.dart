class InvoiceicicytaEntity {
  int? id;
  String? invoiceNo;
  int? loaId;
  String? institution;
  String? email;
  String? presentationType;
  int? memberType;
  int? authorType;
  int? amount;
  String? dateOfIssue;
  int? signatureId;
  int? virtualAccountId;
  int? bankTransferId;
  int? createdBy;
  String? status;
  String? createdAt;
  String? updatedAt;

  InvoiceicicytaEntity(
      {this.id,
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
      this.updatedAt});
}
