import 'package:SummitDocs/Data/transfer_virtual/models/account_virtual_model.dart';
import 'package:SummitDocs/Data/transfer_virtual/models/bank_params.dart';
import 'package:SummitDocs/Data/transfer_virtual/models/delete_bank_model.dart';
import 'package:SummitDocs/Data/transfer_virtual/models/detail_bank_transfer.dart';
import 'package:SummitDocs/Data/transfer_virtual/models/virtual_account_params.dart';
import 'package:SummitDocs/Data/transfer_virtual/sources/transfer_virtual_services.dart';
import 'package:SummitDocs/Domain/transfer_virtual/repositories/transfer_virtual_repository.dart';
import 'package:SummitDocs/core/helper/mapper/delete_bank_mapper.dart';
import 'package:SummitDocs/core/helper/mapper/detail_bank_mapper.dart';
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

  @override
  Future<Either> deleteBankData(int id) async {
    // TODO: implement deleteBankData
    final result =
        await sl<TransferVirtualServices>().deleteBankTransferData(id);

    return result.fold((error) {
      return Left(error);
    }, (data) {
      final model = DeleteBankModel.fromJson(data);
      final dataMapper = DeleteBankMapper.toEntity(model);
      return Right(dataMapper);
    });
  }

  @override
  Future<Either> detailBankTransfer(int id) async {
    // TODO: implement detailBankTransfer
    final result = await sl<TransferVirtualServices>().detailBankTransfer(id);

    return result.fold((error) {
      return Left(error);
    }, (data) {
      final model = DetailBankTransfer.fromJson(data);
      final dataMapper = DetailBankMapper.toEntity(model);
      return Right(dataMapper);
    });
  }

  @override
  Future<Either> getAllVirtualAccountTransfer() async {
    // TODO: implement getAllVirtualAccountTransfer
    final result = await sl<TransferVirtualServices>().getAllVirtualTransfer();
    return result.fold((error) {
      return Left(error);
    }, (data) {
      final dataMapper = List.from(data).map((item) {
        final model = AccountVirtualModel.fromJson(
          item as Map<String, dynamic>,
        );
        return TransferVirtualMapper.toEntityVirtual(model);
      }).toList();
      return Right(dataMapper);
    });
  }

  @override
  Future<Either> sendVirtualAccountData(VirtualAccountParams params) async {
    // TODO: implement sendVirtualAccountData
    final result =
        await sl<TransferVirtualServices>().sendVirtualAccountData(params);
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
