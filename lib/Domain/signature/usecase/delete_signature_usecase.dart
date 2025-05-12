import 'package:SummitDocs/Domain/signature/repository/signature_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';

class DeleteSignatureUsecase extends Usecase<Either, int> {
  @override
  Future<Either> call({int? params}) async {
    // TODO: implement call
    return await sl<SignatureRepository>().deleteSignature(params!);
  }
}
