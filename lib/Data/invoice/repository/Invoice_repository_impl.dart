import 'package:SummitDocs/Data/home/models/invoice_model.dart';
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
      return Left(error['messages']);
    }, (data) {
      final dataMapper = List.from(data).map((element) {
        final model = InvoiceModel.fromJson(element);
        return InvoiceMapper.toEntity(model);
      }).toList();
      return Right(dataMapper);
    });
  }
}
