import 'package:SummitDocs/Data/transfer_virtual/models/detail_bank_transfer.dart';
import 'package:SummitDocs/Domain/transfer_virtual/entity/transfer_virtual_entity.dart';

class DetailBankMapper {
  static TransferVirtualEntity toEntity(DetailBankTransfer detail) {
    return TransferVirtualEntity(
      id: detail.id,
      swiftCode: detail.swiftCode,
      bankBranch: detail.bankBranch,
      beneficiaryBankAccountNo: detail.beneficiaryBankAccountNo,
      country: detail.country,
      namaBank: detail.namaBank,
      createdBy: detail.createdBy,
      city: detail.city,
      bankAddress: detail.bankAddress,
      recipientName: detail.recipientName,
      token: detail.token,
      createdAt: DateTime.tryParse(detail.createdAt ?? ''),
      updatedAt: DateTime.tryParse(detail.updatedAt ?? ''),
    );
  }
}
