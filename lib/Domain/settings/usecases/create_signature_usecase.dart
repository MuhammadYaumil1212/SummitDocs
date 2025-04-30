import 'package:SummitDocs/Data/settings/models/signature_params.dart';
import 'package:SummitDocs/Domain/settings/repositories/settings_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';

class CreateSignatureUsecase extends Usecase<Either, SignatureParams> {
  @override
  Future<Either> call({SignatureParams? params}) async {
    // TODO: implement call
    return await sl<SettingsRepository>().createSignature(params!);
  }
}
