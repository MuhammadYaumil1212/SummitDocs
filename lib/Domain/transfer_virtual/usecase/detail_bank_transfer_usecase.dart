import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../repositories/transfer_virtual_repository.dart';

class DetailBankTransferUsecase extends Usecase<Either, int> {
  @override
  Future<Either> call({int? params}) async {
    // TODO: implement call
    return await sl<TransferVirtualRepository>().detailBankTransfer(params!);
  }
}
