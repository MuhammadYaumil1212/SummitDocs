class ReceiptModel {
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

  ReceiptModel({
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

  ReceiptModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceNo = json['invoice_no'];
    receivedFrom = json['received_from'];
    amount = json['amount'];
    inPaymentOf = json['in_payment_of'];
    paymentDate = json['payment_date'];
    paperId = json['paper_id'];
    paperTitle = json['paper_title'];
    signatureId = int.tryParse(json['signature_id']);
    createdBy = int.tryParse(json['created_by']);
    createdAt =
        json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
    updatedAt =
        json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['invoice_no'] = invoiceNo;
    data['received_from'] = receivedFrom;
    data['amount'] = amount;
    data['in_payment_of'] = inPaymentOf;
    data['payment_date'] = paymentDate;
    data['paper_id'] = paperId;
    data['paper_title'] = paperTitle;
    data['signature_id'] = signatureId;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt?.toIso8601String();
    data['updated_at'] = updatedAt?.toIso8601String();
    return data;
  }
}
