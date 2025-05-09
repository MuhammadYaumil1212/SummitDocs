class UpdateInvoiceParams {
  int? id;
  String? institution;
  String? email;
  String? presentationType;
  String? memberType;
  String? authorType;
  String? amount;
  String? dateOfIssue;
  int? virtualAccountId;
  int? bankTransferId;
  String? status;

  UpdateInvoiceParams({
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
    this.status,
  });

  UpdateInvoiceParams copyWith({
    int? id,
    String? institution,
    String? email,
    String? presentationType,
    String? memberType,
    String? authorType,
    String? amount,
    String? dateOfIssue,
    int? virtualAccountId,
    int? bankTransferId,
    String? status,
  }) {
    return UpdateInvoiceParams(
      id: id ?? this.id,
      institution: institution ?? this.institution,
      email: email ?? this.email,
      presentationType: presentationType ?? this.presentationType,
      memberType: memberType ?? this.memberType,
      authorType: authorType ?? this.authorType,
      amount: amount ?? this.amount,
      dateOfIssue: dateOfIssue ?? this.dateOfIssue,
      virtualAccountId: virtualAccountId ?? this.virtualAccountId,
      bankTransferId: bankTransferId ?? this.bankTransferId,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "institution": institution,
      "email": email,
      "presentation_type": presentationType,
      "member_type": memberType,
      "author_type": authorType,
      "amount": amount,
      "date_of_issue": dateOfIssue,
      "virtual_account_id": virtualAccountId,
      "bank_transfer_id": bankTransferId,
      "status": status,
    };
  }
}
