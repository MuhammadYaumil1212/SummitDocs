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
        return Left(error);
      },
      (data) async {
        await storage.put(AppString.TOKEN_KEY, data['user']['token']);
        await storage.put(AppString.ROLE, data['user']['role']);
        return Right(data);
      },
    );
  }
}
