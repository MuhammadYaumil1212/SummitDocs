import 'package:SummitDocs/Data/LoA/models/update_loa_params.dart';
import 'package:SummitDocs/Domain/LoA/repositories/Loa_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';

class UpdateLoaUsecase extends Usecase<Either, UpdateLoaParams> {
  @override
  Future<Either> call({UpdateLoaParams? params}) async {
    // TODO: implement call
    return await sl<LoaRepository>().updateLOA(params!);
  }
}
