import 'package:SummitDocs/Data/signature/models/signature_model.dart';
import 'package:SummitDocs/Domain/signature/entity/signature_entity.dart';

class SignatureMapper {
  static SignatureEntity toEntity(SignatureModel loaModel) {
    return SignatureEntity(
      id: loaModel.id,
      jabatanPenandatangan: loaModel.jabatanPenandatangan,
      namaPenandatangan: loaModel.jabatanPenandatangan,
      picture: loaModel.picture,
      tanggalDibuat: loaModel.tanggalDibuat,
      createdAt: DateTime.tryParse(loaModel.createdAt ?? ''),
      updatedAt: DateTime.tryParse(loaModel.updatedAt ?? ''),
    );
  }
}
