class AccountVirtualModel {
  int? id;
  String? nomorVirtualAkun;
  String? accountHolderName;
  String? bankName;
  String? bankBranch;
  String? token;
  int? createdBy;
  String? createdAt;
  String? updatedAt;

  AccountVirtualModel(
      {this.id,
      this.nomorVirtualAkun,
      this.accountHolderName,
      this.bankName,
      this.bankBranch,
      this.token,
      this.createdBy,
      this.createdAt,
      this.updatedAt});

  AccountVirtualModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nomorVirtualAkun = json['nomor_virtual_akun'];
    accountHolderName = json['account_holder_name'];
    bankName = json['bank_name'];
    bankBranch = json['bank_branch'];
    token = json['token'];
    createdBy = int.tryParse(json['created_by']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nomor_virtual_akun'] = this.nomorVirtualAkun;
    data['account_holder_name'] = this.accountHolderName;
    data['bank_name'] = this.bankName;
    data['bank_branch'] = this.bankBranch;
    data['token'] = this.token;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
