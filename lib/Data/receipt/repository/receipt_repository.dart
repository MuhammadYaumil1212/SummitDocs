import 'package:SummitDocs/Data/receipt/sources/receipt_services.dart';
import 'package:SummitDocs/Domain/receipt/repositories/receipt_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/helper/mapper/receipt_mapper.dart';
import '../../../service_locator.dart';
import '../models/receipt_model.dart';

class ReceiptRepositoryImpl extends ReceiptRepository {
  @override
  Future<Either> getAllReceiptsIcicyta() async {
    // TODO: implement getAllReceipts
    final response = await sl<ReceiptServices>().getAllReceiptsIcicyta();
    return response.fold((error) {
      return Left(error['errors']);
    }, (data) {
      final dataMapper = List.from(data).map((entity) {
        return ReceiptMapper.toEntity(ReceiptModel.fromJson(entity));
      }).toList();
      return Right(dataMapper);
    });
  }

  @override
  Future<Either> getAllReceiptsIcodsa() async {
    // TODO: implement getAllReceiptsIcodsa
    final response = await sl<ReceiptServices>().getAllReceiptsIcodsa();
    return response.fold((error) {
      return Left(error['errors']);
    }, (data) {
      final dataMapper = List.from(data).map((entity) {
        return ReceiptMapper.toEntity(ReceiptModel.fromJson(entity));
      }).toList();
      return Right(dataMapper);
    });
  }
}
