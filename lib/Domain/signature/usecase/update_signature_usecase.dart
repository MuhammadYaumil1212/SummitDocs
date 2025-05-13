import 'package:SummitDocs/Data/settings/models/signature_params.dart';
import 'package:SummitDocs/Domain/signature/repository/signature_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../Data/signature/models/signature_params_admin.dart';
import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';

class UpdateSignatureUsecase extends Usecase<Either, SignatureParamsAdmin> {
  @override
  Future<Either> call({SignatureParamsAdmin? params}) async {
    // TODO: implement call
    return await sl<SignatureRepository>().updateSignatureList(params!);
  }
}
