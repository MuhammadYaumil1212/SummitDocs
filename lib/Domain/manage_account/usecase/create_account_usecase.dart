import 'package:SummitDocs/Data/manage_account/models/create_account_model.dart';
import 'package:SummitDocs/Data/manage_account/models/create_account_params.dart';
import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../repositories/manage_account_repository.dart';

class CreateAccountUsecase extends Usecase<Either, CreateAccountParams> {
  @override
  Future<Either> call({CreateAccountParams? params}) async {
    // TODO: implement call
    return await sl<ManageAccountRepository>().createAccount(params!);
  }
}
