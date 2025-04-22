import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../commons/constants/api_url.dart';
import '../../../core/network/dio_client.dart';
import '../../../service_locator.dart';

abstract class HomesServices {
  Future<Either> getHistoryLOA();
  Future<Either> getHistoryIcodsaInvoice();
}

class HomeServicesImpl extends HomesServices {
  @override
  Future<Either> getHistoryLOA() async {
    // TODO: implement getHistoryLOA
    try {
      var response = await sl<DioClient>().get(
        ApiUrl.getDocsLOA,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data ?? "Something Gone Wrong!");
    }
  }

  @override
  Future<Either> getHistoryIcodsaInvoice() async {
    // TODO: implement getHistoryInvoice
    try {
      var response = await sl<DioClient>().get(
        ApiUrl.getIcodsaInvoice,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data ?? "Something Gone Wrong!");
    }
  }
}
