import 'package:SummitDocs/Data/home/models/invoice_model.dart';
import 'package:SummitDocs/Data/invoice/models/update_invoice_params.dart';
import 'package:SummitDocs/Data/invoice/sources/invoice_services.dart';
import 'package:SummitDocs/Domain/invoice/repository/invoice_repository.dart';
import 'package:SummitDocs/core/helper/mapper/invoice_mapper.dart';
import 'package:dartz/dartz.dart';

import '../../../service_locator.dart';

class InvoiceRepositoryImpl extends InvoiceRepository {
  @override
  Future<Either> getInvoiceIcicytaList() async {
    // TODO: implement getInvoiceIcicytaList
    final response = await sl<InvoiceServices>().getAllListInvoiceIcicyta();
    return response.fold((error) {
      return Left(error['message']);
    }, (data) {
      final dataMapper = List.from(data).map((element) {
        final model = InvoiceModel.fromJson(element);
        return InvoiceMapper.toEntity(model);
      }).toList();
      return Right(dataMapper);
    });
  }

  @override
  Future<Either> updateInvoiceIcicyta(UpdateInvoiceParams params) async {
    // TODO: implement updateInvoiceIcicyta
    final response = await sl<InvoiceServices>().updateInvoiceIcicyta(params);
    return response.fold((error) {
      print("error repo : ${error}");
      return Left(error['errors'] ?? error['message']);
    }, (data) {
      return Right(data['message']);
    });
  }
}
