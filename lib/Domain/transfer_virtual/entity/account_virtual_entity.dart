class AccountVirtualEntity {
  int? id;
  String? nomorVirtualAkun;
  String? accountHolderName;
  String? bankName;
  String? bankBranch;
  String? token;
  int? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  AccountVirtualEntity(
      {this.id,
      this.nomorVirtualAkun,
      this.accountHolderName,
      this.bankName,
      this.bankBranch,
      this.token,
      this.createdBy,
      this.createdAt,
      this.updatedAt});
}
