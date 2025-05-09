//get_all_receipt_icicyta_usecase
import 'package:SummitDocs/Domain/receipt/entity/receipt_entity.dart';
import 'package:SummitDocs/Domain/receipt/repositories/receipt_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../../LoA/repositories/Loa_repository.dart';

class GetAllReceiptIcicytaUsecase extends Usecase<Either, ReceiptEntity> {
  @override
  Future<Either> call({ReceiptEntity? params}) async {
    // TODO: implement call
    return await sl<ReceiptRepository>().getAllReceipts();
  }
}
