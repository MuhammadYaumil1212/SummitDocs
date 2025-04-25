import 'package:SummitDocs/Data/transfer_virtual/models/delete_bank_model.dart';
import 'package:SummitDocs/Domain/transfer_virtual/entity/delete_bank_entity.dart';

class DeleteBankMapper {
  static DeleteBankEntity toEntity(DeleteBankModel delete) {
    return DeleteBankEntity(message: delete.message);
  }
}
