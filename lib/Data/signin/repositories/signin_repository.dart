import 'package:berkas_conference/Data/signin/models/signinParams.dart';
import 'package:berkas_conference/Data/signin/sources/signin_service.dart';
import 'package:berkas_conference/Domain/signin/repositories/signin_repository.dart';
import 'package:berkas_conference/commons/constants/string.dart';
import 'package:dartz/dartz.dart';

import '../../../core/helper/storage/AppStorage.dart';
import '../../../service_locator.dart';

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
        return Right(data);
      },
    );
  }
}
