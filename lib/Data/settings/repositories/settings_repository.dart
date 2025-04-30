import 'package:SummitDocs/Data/settings/models/signature_params.dart';
import 'package:SummitDocs/Domain/settings/repositories/settings_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../service_locator.dart';
import '../source/settings_services.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  @override
  Future<Either> createSignature(SignatureParams params) async {
    // TODO: implement createSignature
    final response = await sl<SettingsServices>().uploadSignature(params);
    return response.fold(
      (error) {
        return Left(error['errors']);
      },
      (data) {
        return Right(data['message']);
      },
    );
  }
}
