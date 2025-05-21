class TransferVirtualModel {
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
  String? createdAt;
  String? updatedAt;

  TransferVirtualModel(
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

  TransferVirtualModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaBank = json['nama_bank'];
    swiftCode = json['swift_code'];
    recipientName = json['recipient_name'];
    beneficiaryBankAccountNo = json['beneficiary_bank_account_no'];
    bankBranch = json['bank_branch'];
    bankAddress = json['bank_address'];
    city = json['city'];
    country = json['country'];
    token = json['token'];
    createdBy = int.tryParse(json['created_by']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_bank'] = this.namaBank;
    data['swift_code'] = this.swiftCode;
    data['recipient_name'] = this.recipientName;
    data['beneficiary_bank_account_no'] = this.beneficiaryBankAccountNo;
    data['bank_branch'] = this.bankBranch;
    data['bank_address'] = this.bankAddress;
    data['city'] = this.city;
    data['country'] = this.country;
    data['token'] = this.token;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
