class TransferVirtualEntity {
  int? id;
  String? namaBank;
  String? swiftCode;
  String? recipientName;
  String? beneficiaryBankAccountNo;
  String? bankBranch;
  String? bankAddress;
  String? city;
  String? country;
  String? token;
  int? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  TransferVirtualEntity(
      {this.id,
      this.namaBank,
      this.swiftCode,
      this.recipientName,
      this.beneficiaryBankAccountNo,
      this.bankBranch,
      this.bankAddress,
      this.city,
      this.country,
      this.token,
      this.createdBy,
      this.createdAt,
      this.updatedAt});
}
