import 'package:SummitDocs/Data/invoice/models/update_invoice_params.dart';
import 'package:SummitDocs/commons/constants/api_url.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/network/dio_client.dart';
import '../../../service_locator.dart';

abstract class InvoiceServices {
  Future<Either> getAllListInvoiceIcicyta();
  Future<Either> updateInvoiceIcicyta(UpdateInvoiceParams params);
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

  @override
  Future<Either> updateInvoiceIcicyta(UpdateInvoiceParams params) async {
    // TODO: implement updateInvoiceIcicyta
    try {
      var response = await sl<DioClient>().put(
        "${ApiUrl.updateIcicytaInvoice}${params.id}",
        data: params.toMap(),
      );
      print("Response update : ${response.data}");
      return Right(response.data);
    } on DioException catch (e) {
      print("error response : ${e.response?.data}");
      return Left(e.response?.data ?? "Something Gone Wrong!");
    }
  }
}
