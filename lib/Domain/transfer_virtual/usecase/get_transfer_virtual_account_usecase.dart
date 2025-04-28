import 'package:SummitDocs/Data/transfer_virtual/models/account_virtual_model.dart';
import 'package:dartz/dartz.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../repositories/transfer_virtual_repository.dart';

class GetTransferVirtualAccountUsecase
    extends Usecase<Either, AccountVirtualModel> {
  @override
  Future<Either> call({AccountVirtualModel? params}) async {
    // TODO: implement call
    return await sl<TransferVirtualRepository>().getAllVirtualAccountTransfer();
  }
}
