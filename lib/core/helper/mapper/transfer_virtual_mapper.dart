import 'package:SummitDocs/Data/transfer_virtual/models/account_virtual_model.dart';
import 'package:SummitDocs/Data/transfer_virtual/models/transfer_virtual_model.dart';
import 'package:SummitDocs/Domain/transfer_virtual/entity/account_virtual_entity.dart';
import 'package:SummitDocs/Domain/transfer_virtual/entity/transfer_virtual_entity.dart';

import '../../../Domain/transfer_virtual/entity/account_virtual_entity.dart';

class TransferVirtualMapper {
  static TransferVirtualEntity toEntity(TransferVirtualModel transfer) {
    return TransferVirtualEntity(
      id: transfer.id,
      bankAddress: transfer.bankAddress,
      bankBranch: transfer.bankBranch,
      namaBank: transfer.namaBank,
      beneficiaryBankAccountNo: transfer.beneficiaryBankAccountNo,
      city: transfer.city,
      country: transfer.country,
      recipientName: transfer.recipientName,
      swiftCode: transfer.swiftCode,
      token: transfer.token,
      createdAt: DateTime.tryParse(transfer.createdAt ?? ''),
      updatedAt: DateTime.tryParse(transfer.updatedAt ?? ''),
      createdBy: transfer.createdBy,
    );
  }

  static AccountVirtualEntity toEntityVirtual(AccountVirtualModel transfer) {
    return AccountVirtualEntity(
      id: transfer.id,
      bankName: transfer.bankName,
      bankBranch: transfer.bankBranch,
      accountHolderName: transfer.accountHolderName,
      token: transfer.token,
      nomorVirtualAkun: transfer.nomorVirtualAkun,
      createdBy: transfer.createdBy,
      updatedAt: DateTime.tryParse(transfer.updatedAt ?? ''),
      createdAt: DateTime.tryParse(transfer.createdAt ?? ''),
    );
  }
}
