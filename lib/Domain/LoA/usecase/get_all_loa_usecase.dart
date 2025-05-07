import 'package:SummitDocs/Domain/LoA/entity/loa_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../repositories/Loa_repository.dart';

class GetAllLoaUsecase extends Usecase<Either, LoaEntity> {
  @override
  Future<Either> call({LoaEntity? params}) async {
    // TODO: implement call
    return await sl<LoaRepository>().getAllLoa();
  }
}
