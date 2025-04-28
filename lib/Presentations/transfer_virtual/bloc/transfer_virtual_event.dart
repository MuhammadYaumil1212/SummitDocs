part of 'transfer_virtual_bloc.dart';

sealed class TransferVirtualEvent extends Equatable {
  const TransferVirtualEvent();
}

final class LoadTransferBankVirtual extends TransferVirtualEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class SendBankTransferData extends TransferVirtualEvent {
  final String namaBank;
  final String swiftCode;
  final String receipientName;
  final String beneficiaryBankAccountNo;
  final String bankBranch;
  final String bankAddress;
  final String city;
  final String country;

  SendBankTransferData({
    required this.namaBank,
    required this.swiftCode,
    required this.receipientName,
    required this.beneficiaryBankAccountNo,
    required this.bankBranch,
    required this.bankAddress,
    required this.city,
    required this.country,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        namaBank,
        swiftCode,
        receipientName,
        beneficiaryBankAccountNo,
        bankBranch,
        bankAddress,
        city,
        country,
      ];
}

final class DeleteTransferData extends TransferVirtualEvent {
  final int id;
  DeleteTransferData({required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

final class LoadDetailBank extends TransferVirtualEvent {
  final int id;
  LoadDetailBank({required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

final class LoadVirtualAccount extends TransferVirtualEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class SendVirtualAccount extends TransferVirtualEvent {
  final String noVirtualAccount;
  final String accountHolderName;
  final String bankName;
  final String bankBranch;
  SendVirtualAccount({
    required this.noVirtualAccount,
    required this.accountHolderName,
    required this.bankName,
    required this.bankBranch,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        noVirtualAccount,
        accountHolderName,
        bankName,
        bankBranch,
      ];
}
