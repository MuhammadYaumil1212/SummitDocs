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
