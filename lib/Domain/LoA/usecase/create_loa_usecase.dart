import 'package:dartz/dartz.dart';

import '../../../Data/LoA/models/update_loa_params.dart';
import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../repositories/Loa_repository.dart';

class CreateLoaUsecase extends Usecase<Either, UpdateLoaParams> {
  @override
  Future<Either> call({UpdateLoaParams? params}) async {
    // TODO: implement call
    return await sl<LoaRepository>().createLOA(params!);
  }
}
