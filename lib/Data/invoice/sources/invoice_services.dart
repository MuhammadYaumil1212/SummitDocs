import 'package:SummitDocs/commons/constants/api_url.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/network/dio_client.dart';
import '../../../service_locator.dart';

abstract class InvoiceServices {
  Future<Either> getAllListInvoiceIcicyta();
}

class InvoiceServicesImpl extends InvoiceServices {
  @override
  Future<Either> getAllListInvoiceIcicyta() async {
    // TODO: implement getAllListInvoiceIcicyta
    try {
      var response = await sl<DioClient>().get(ApiUrl.getIcicytaInvoice);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data ?? "Something Gone Wrong!");
    }
  }
}
