import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../commons/constants/api_url.dart';
import '../../../core/network/dio_client.dart';
import '../../../service_locator.dart';

abstract class SignatureServices {
  Future<Either> getSignatureList();
  Future<Either> deleteSignature(int id);
}

class SignatureServicesImpl extends SignatureServices {
  @override
  Future<Either> getSignatureList() async {
    // TODO: implement getSignatureList
    try {
      var response = await sl<DioClient>().get(
        ApiUrl.getSignature,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data ?? "Something Gone Wrong!");
    }
  }

  @override
  Future<Either> deleteSignature(int id) async {
    // TODO: implement deleteSignature
    try {
      var response = await sl<DioClient>().delete(
        ApiUrl.deleteSignature + "$id",
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response?.data ?? "Something Gone Wrong!");
    }
  }
}
