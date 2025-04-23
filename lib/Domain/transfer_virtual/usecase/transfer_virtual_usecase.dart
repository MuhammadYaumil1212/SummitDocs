import 'package:SummitDocs/Data/transfer_virtual/models/transfer_virtual_model.dart';
import 'package:SummitDocs/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../service_locator.dart';
import '../repositories/transfer_virtual_repository.dart';

class TransferVirtualUsecase extends Usecase<Either, TransferVirtualModel> {
  @override
  Future<Either> call({TransferVirtualModel? params}) async {
    // TODO: implement call
    return await sl<TransferVirtualRepository>().getAllBankTransfer();
  }
}
