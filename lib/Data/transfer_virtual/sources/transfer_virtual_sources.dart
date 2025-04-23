import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../commons/constants/api_url.dart';
import '../../../core/network/dio_client.dart';
import '../../../service_locator.dart';

abstract class TransferVirtualServices {
  Future<Either> getAllBankTransfer();
  Future<Either> getAllVirtualTransfer();
}

class TransferVirtualServicesImpl extends TransferVirtualServices {
  @override
  Future<Either> getAllBankTransfer() async {
    // TODO: implement getAllBankTransfer
    try {
      var response = await sl<DioClient>().get(
        ApiUrl.getAllListBank,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data ?? "Something Gone Wrong!");
    }
  }

  @override
  Future<Either> getAllVirtualTransfer() {
    // TODO: implement getAllVirtualTransfer
    throw UnimplementedError();
  }
}
