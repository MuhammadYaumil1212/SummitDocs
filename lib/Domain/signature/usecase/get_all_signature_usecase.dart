import 'package:SummitDocs/Data/signature/models/signature_model.dart';
import 'package:SummitDocs/Domain/signature/repository/signature_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';

class GetAllSignatureUsecase extends Usecase<Either, SignatureModel> {
  @override
  Future<Either> call({SignatureModel? params}) async {
    // TODO: implement call
    return await sl<SignatureRepository>().getSignatureList();
  }
}
