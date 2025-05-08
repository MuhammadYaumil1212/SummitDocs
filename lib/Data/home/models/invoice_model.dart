class InvoiceModel {
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

  InvoiceModel({
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
  });

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceNo = json['invoice_no'];
    loaId = json['loa_id'];
    institution = json['institution'];
    email = json['email'];
    presentationType = json['presentation_type'];
    memberType = json['member_type'];
    authorType = json['author_type'];
    amount = json['amount'];
    dateOfIssue = json['date_of_issue'];
    signatureId = json['signature_id'];
    virtualAccountId = json['virtual_account_id'];
    bankTransferId = json['bank_transfer_id'];
    createdBy = json['created_by'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['invoice_no'] = this.invoiceNo;
    data['loa_id'] = this.loaId;
    data['institution'] = this.institution;
    data['email'] = this.email;
    data['presentation_type'] = this.presentationType;
    data['member_type'] = this.memberType;
    data['author_type'] = this.authorType;
    data['amount'] = this.amount;
    data['date_of_issue'] = this.dateOfIssue;
    data['signature_id'] = this.signatureId;
    data['virtual_account_id'] = this.virtualAccountId;
    data['bank_transfer_id'] = this.bankTransferId;
    data['created_by'] = this.createdBy;
    data['status'] = this.status;
    return data;
  }
}
