import 'package:berkas_conference/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../Data/signin/models/signinParams.dart';
import '../../../service_locator.dart';
import '../repositories/signin_repository.dart';

class SigninUsecase extends Usecase<Either, SigninParams> {
  @override
  Future<Either> call({SigninParams? params}) async {
    // TODO: implement call
    return await sl<SigninRepository>().signin(params!);
  }
}
