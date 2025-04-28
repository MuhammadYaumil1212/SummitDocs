import 'package:SummitDocs/Data/transfer_virtual/models/virtual_account_params.dart';
import 'package:dartz/dartz.dart';

import '../../../Data/transfer_virtual/models/account_virtual_model.dart';
import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../repositories/transfer_virtual_repository.dart';

class SaveVirtualAccountUsecase extends Usecase<Either, VirtualAccountParams> {
  @override
  Future<Either> call({VirtualAccountParams? params}) async {
    // TODO: implement call
    return await sl<TransferVirtualRepository>()
        .sendVirtualAccountData(params!);
  }
}
