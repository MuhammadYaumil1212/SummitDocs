import 'package:SummitDocs/Data/transfer_virtual/models/transfer_virtual_model.dart';
import 'package:SummitDocs/Domain/transfer_virtual/entity/transfer_virtual_entity.dart';

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
      updatedAt: transfer.updatedAt,
      createdAt: transfer.createdAt,
      createdBy: transfer.createdBy,
    );
  }
}
