import 'package:SummitDocs/Data/signin/models/signinParams.dart';
import 'package:SummitDocs/commons/constants/api_url.dart';
import 'package:SummitDocs/core/network/dio_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../service_locator.dart';

abstract class SigninService {
  Future<Either> signin(SigninParams params);
}

class SigninServiceImpl extends SigninService {
  @override
  Future<Either> signin(SigninParams params) async {
    // TODO: implement signin
    try {
      var response = await sl<DioClient>().post(
        ApiUrl.login,
        data: params.toMap(),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? "Something Gone Wrong!");
    }
  }
}
