import 'package:SummitDocs/Data/home/models/invoice_model.dart';
import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../repositories/home_repository.dart';

class GetInvoiceIcodsaUsecase extends Usecase<Either, InvoiceModel> {
  @override
  Future<Either> call({InvoiceModel? params}) async {
    // TODO: implement call
    return await sl<HomeRepository>().getHistoryIcodsaInvoice();
  }
}
