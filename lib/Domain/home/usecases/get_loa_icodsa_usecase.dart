import 'package:SummitDocs/Data/home/models/loa_model.dart';
import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../repositories/home_repository.dart';

class GetLoaIcodsaUsecase extends Usecase<Either, LoaModel> {
  @override
  Future<Either> call({LoaModel? params}) async {
    // TODO: implement call
    return await sl<HomeRepository>().getHistoryIcicytaLOA();
  }
}
