import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../commons/constants/api_url.dart';
import '../../../core/network/dio_client.dart';
import '../../../service_locator.dart';

abstract class ReceiptServices {
  Future<Either> getAllReceipts();
}

class ReceiptServicesImpl implements ReceiptServices {
  @override
  Future<Either> getAllReceipts() async {
    // TODO: implement getAllReceipts
    try {
      var response = await sl<DioClient>().get(ApiUrl.getReceiptIcicyta);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data ?? "Something Gone Wrong!");
    }
  }
}
