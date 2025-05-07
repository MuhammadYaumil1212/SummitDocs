import 'package:SummitDocs/Data/LoA/models/load_model.dart';
import 'package:SummitDocs/Domain/LoA/entity/loa_entity.dart';

class LoaMapper {
  static LoaEntity toEntity(LoaModel loaModel) {
    return LoaEntity(
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
