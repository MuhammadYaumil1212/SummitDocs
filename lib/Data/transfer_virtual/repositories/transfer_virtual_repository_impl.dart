import 'package:SummitDocs/Data/transfer_virtual/models/bank_params.dart';
import 'package:SummitDocs/Data/transfer_virtual/sources/transfer_virtual_sources.dart';
import 'package:SummitDocs/Domain/transfer_virtual/repositories/transfer_virtual_repository.dart';
import 'package:SummitDocs/core/helper/mapper/transfer_virtual_mapper.dart';
import 'package:dartz/dartz.dart';

import '../../../service_locator.dart';
import '../models/transfer_virtual_model.dart';

class TransferVirtualRepositoryImpl extends TransferVirtualRepository {
  @override
  Future<Either> getAllBankTransfer() async {
    // TODO: implement getAllBankTransfer
    final result = await sl<TransferVirtualServices>().getAllBankTransfer();
    return result.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        final dataMapper = List.from(data).map((item) {
          final model = TransferVirtualModel.fromJson(
            item as Map<String, dynamic>,
          );
          return TransferVirtualMapper.toEntity(model);
        }).toList();
        return Right(dataMapper);
      },
    );
  }

  @override
  Future<Either> getAllVirtualTransfer() {
    // TODO: implement getAllVirtualTransfer
    throw UnimplementedError();
  }

  @override
  Future<Either> sendBankData(BankParams params) async {
    // TODO: implement sendBankData
    final result = await sl<TransferVirtualServices>().sendBankTransferData(
      params,
    );
    return result.fold(
      (error) {
        return Left(error['errors']);
      },
      (data) {
        return Right(data['message']);
      },
    );
  }
}
