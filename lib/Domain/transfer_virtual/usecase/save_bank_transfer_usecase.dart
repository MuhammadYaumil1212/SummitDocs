import 'package:SummitDocs/Data/transfer_virtual/models/bank_params.dart';
import 'package:SummitDocs/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../service_locator.dart';
import '../repositories/transfer_virtual_repository.dart';

class SaveBankTransferUsecase extends Usecase<Either, BankParams> {
  @override
  Future<Either> call({BankParams? params}) async {
    // TODO: implement call
    return await sl<TransferVirtualRepository>().sendBankData(params!);
  }
}
