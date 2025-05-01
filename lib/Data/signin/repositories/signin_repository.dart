import 'package:SummitDocs/Data/signin/models/signin_models.dart';
import 'package:SummitDocs/core/helper/mapper/signin_mapper.dart';
import 'package:dartz/dartz.dart';

import '../../../Domain/signin/repositories/signin_repository.dart';
import '../../../commons/constants/string.dart';
import '../../../core/helper/storage/AppStorage.dart';
import '../../../service_locator.dart';
import '../models/signinParams.dart';
import '../sources/signin_service.dart';

class SigninRepositoryImpl extends SigninRepository {
  final storage = AppStorage.instance;
  @override
  Future<Either> signin(SigninParams params) async {
    // TODO: implement signin
    var result = await sl<SigninService>().signin(params);
    return result.fold(
      (error) {
        return Left(error['message']);
      },
      (data) async {
        await storage.put(AppString.TOKEN_KEY, data['token']);
        await storage.put(AppString.ROLE, data['user']['role']);
        await storage.put(AppString.USERNAME, data['user']['username']);
        await storage.put(AppString.EMAIL, data['user']['email']);
        await storage.put(AppString.ID, data['user']['id']);
        await storage.put(AppString.NAME, data['user']['name']);
        final resultDataMapper = SigninMapper.toEntity(
          SigninModels.fromJson(data),
        );
        return Right(resultDataMapper);
      },
    );
  }
}
