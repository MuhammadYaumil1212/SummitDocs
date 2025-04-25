class BankParams {
  String namaBank;
  String swiftCode;
  String receipientName;
  String beneficiaryBankAccountNo;
  String bankBranch;
  String bankAddress;
  String city;
  String country;

  BankParams({
    required this.namaBank,
    required this.swiftCode,
    required this.receipientName,
    required this.beneficiaryBankAccountNo,
    required this.bankBranch,
    required this.bankAddress,
    required this.city,
    required this.country,
  });

  BankParams copyWith({
    String? namaBank,
    String? swiftCode,
    String? receipientName,
    String? beneficiaryBankAccountNo,
    String? bankBranch,
    String? bankAddress,
    String? city,
    String? country,
  }) {
    return BankParams(
      namaBank: namaBank ?? this.namaBank,
      swiftCode: swiftCode ?? this.swiftCode,
      receipientName: receipientName ?? this.receipientName,
      beneficiaryBankAccountNo:
          beneficiaryBankAccountNo ?? this.beneficiaryBankAccountNo,
      bankBranch: bankBranch ?? this.bankBranch,
      bankAddress: bankAddress ?? this.bankAddress,
      city: city ?? this.city,
      country: country ?? this.country,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nama_bank': namaBank,
      'swift_code': swiftCode,
      'recipient_name': receipientName,
      'beneficiary_bank_account_no': beneficiaryBankAccountNo,
      'bank_branch': bankBranch,
      'bank_address': bankAddress,
      'city': city,
      'country': country,
    };
  }
}

///  "nama_bank": "PT BANK JAGO INDONESIA TBK",
//   "swift_code": "JGOOOO",
//   "recipient_name": "Universitas Telkom",
//   "beneficiary_bank_account_no": "1310095019916",
//   "bank_branch": "Jakarta",
//   "bank_address": "THE TOWER, GATOT SUBROTO 27, KARET, SETIABUDI",
//   "city": "Jakarta",
//   "country": "Indonesia"
