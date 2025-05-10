import 'package:SummitDocs/Data/home/models/loa_model.dart';
import 'package:SummitDocs/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../service_locator.dart';
import '../repositories/home_repository.dart';

class LOAUsecase extends Usecase<Either, LOAModel> {
  @override
  Future<Either> call({LOAModel? params}) async {
    // TODO: implement call
    return await sl<HomeRepository>().getHistoryIcodsaLOA();
  }
}
