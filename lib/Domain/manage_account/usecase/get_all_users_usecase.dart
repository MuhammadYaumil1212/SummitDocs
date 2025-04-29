import 'package:SummitDocs/Data/manage_account/models/user_model.dart';
import 'package:SummitDocs/Domain/manage_account/repositories/manage_account_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';

class GetAllUsersUsecase extends Usecase<Either, UserModel> {
  @override
  Future<Either> call({UserModel? params}) async {
    // TODO: implement call
    return await sl<ManageAccountRepository>().getAllUser();
  }
}
