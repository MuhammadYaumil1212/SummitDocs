import 'package:dartz/dartz.dart';

import '../../../Data/invoice/models/update_invoice_params.dart';

abstract class InvoiceRepository {
  Future<Either> getInvoiceIcicytaList();
  Future<Either> updateInvoiceIcicyta(UpdateInvoiceParams params);
}
