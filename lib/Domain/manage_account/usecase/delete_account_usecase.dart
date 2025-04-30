import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../repositories/manage_account_repository.dart';

class DeleteAccountUsecase extends Usecase<Either, int> {
  @override
  Future<Either> call({int? params}) async {
    // TODO: implement call
    return await sl<ManageAccountRepository>().deleteAccount(params!);
  }
}
