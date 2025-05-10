import 'package:SummitDocs/Data/home/models/loa_model.dart';
import 'package:SummitDocs/Domain/home/entities/LoaEntity.dart';

class LoaMapperHome {
  static LoaEntityHome toEntity(LoaModel loaModel) {
    return LoaEntityHome(
      id: loaModel.id,
      paperId: loaModel.paperId,
      signatureId: loaModel.signatureId,
      paperTitle: loaModel.paperTitle,
      authorNames: loaModel.authorNames,
      status: loaModel.status,
      tempatTanggal: loaModel.tempatTanggal,
      createdBy: loaModel.createdBy,
      createdAt: DateTime.tryParse(loaModel.createdAt ?? ''),
      updatedAt: DateTime.tryParse(loaModel.updatedAt ?? ''),
    );
  }
}
