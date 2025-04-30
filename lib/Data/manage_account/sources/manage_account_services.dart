import 'package:SummitDocs/Data/manage_account/models/create_account_params.dart';
import 'package:SummitDocs/core/network/dio_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../commons/constants/api_url.dart';
import '../../../service_locator.dart';

abstract class ManageAccountServices {
  Future<Either> getAllUser();
  Future<Either> createAccount(CreateAccountParams params);
  Future<Either> deleteAccount(int id);
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

  @override
  Future<Either> createAccount(CreateAccountParams params) async {
    // TODO: implement createAccount
    try {
      var response = await sl<DioClient>().post(
        params.role == "Admin ICODSA"
            ? ApiUrl.createIcodsa
            : ApiUrl.createIcicyta,
        data: params.toMap(),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data ?? "Something Gone Wrong!");
    }
  }

  @override
  Future<Either> deleteAccount(int id) async {
    // TODO: implement deleteAccount
    try {
      final response = await sl<DioClient>().delete(
        "${ApiUrl.deleteAdmin}$id",
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response?.data ?? "Something Gone Wrong!");
    }
  }
}
