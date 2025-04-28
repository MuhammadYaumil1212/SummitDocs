class VirtualAccountParams {
  final String noVirtualAccount;
  final String accountHolderName;
  final String bankName;
  final String bankBranch;

  VirtualAccountParams({
    required this.noVirtualAccount,
    required this.accountHolderName,
    required this.bankName,
    required this.bankBranch,
  });

  VirtualAccountParams copyWith({
    String? noVirtualAccount,
    String? accountHolderName,
    String? bankName,
    String? bankBranch,
  }) {
    return VirtualAccountParams(
      noVirtualAccount: noVirtualAccount ?? this.noVirtualAccount,
      accountHolderName: accountHolderName ?? this.accountHolderName,
      bankName: bankName ?? this.bankName,
      bankBranch: bankBranch ?? this.bankBranch,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nomor_virtual_akun': noVirtualAccount,
      'account_holder_name': accountHolderName,
      'bank_name': bankName,
      'bank_branch': bankBranch,
    };
  }
}
