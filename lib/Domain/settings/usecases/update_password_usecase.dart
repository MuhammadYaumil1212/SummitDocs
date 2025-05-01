import 'package:SummitDocs/Data/settings/models/new_password_params.dart';
import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../repositories/settings_repository.dart';

class UpdatePasswordUsecase extends Usecase<Either, NewPasswordParams> {
  @override
  Future<Either> call({NewPasswordParams? params}) async {
    // TODO: implement call
    return await sl<SettingsRepository>().resetPassword(params!);
  }
}
