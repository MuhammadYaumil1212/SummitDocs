import 'package:SummitDocs/core/network/dio_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../commons/constants/api_url.dart';
import '../../../service_locator.dart';

abstract class ManageAccountServices {
  Future<Either> getAllUser();
}

class ManageAccountServicesImpl extends ManageAccountServices {
  @override
  Future<Either> getAllUser() async {
    // TODO: implement getAllUser
    try {
      var response = await sl<DioClient>().get(
        ApiUrl.getAllUsers,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data ?? "Something Gone Wrong!");
    }
  }
}
