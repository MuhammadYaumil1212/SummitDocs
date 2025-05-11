import 'package:SummitDocs/Domain/home/entities/invoice_entity.dart';
import 'package:SummitDocs/Domain/invoice/repository/invoice_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';

class GetAllInvoiceIcodsaUsecase extends Usecase<Either, InvoiceEntity> {
  @override
  Future<Either> call({InvoiceEntity? params}) async {
    // TODO: implement call
    return await sl<InvoiceRepository>().getInvoiceIcodsaList();
  }
}
