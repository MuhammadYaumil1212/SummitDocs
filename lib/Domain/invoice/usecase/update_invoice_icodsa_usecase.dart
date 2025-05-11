import 'package:SummitDocs/Data/invoice/models/update_invoice_params.dart';
import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../repository/invoice_repository.dart';

class UpdateInvoiceIcodsaUsecase extends Usecase<Either, UpdateInvoiceParams> {
  @override
  Future<Either> call({UpdateInvoiceParams? params}) async {
    // TODO: implement call
    return await sl<InvoiceRepository>().updateInvoiceIcodsa(params!);
  }
}
