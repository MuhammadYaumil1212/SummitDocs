import 'package:SummitDocs/Data/home/models/invoice_model.dart';
import 'package:dartz/dartz.dart';

import '../../../Data/home/models/loa_model.dart';
import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../repositories/home_repository.dart';

class InvoiceUsecase extends Usecase<Either, InvoiceModel> {
  @override
  Future<Either> call({InvoiceModel? params}) async {
    // TODO: implement call
    return await sl<HomeRepository>().getHistoryIcodsaInvoice();
  }
}
