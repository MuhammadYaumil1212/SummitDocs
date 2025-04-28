import 'package:SummitDocs/Data/transfer_virtual/models/bank_params.dart';
import 'package:SummitDocs/Data/transfer_virtual/models/virtual_account_params.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../commons/constants/api_url.dart';
import '../../../core/network/dio_client.dart';
import '../../../service_locator.dart';

abstract class TransferVirtualServices {
  Future<Either> getAllBankTransfer();
  Future<Either> getAllVirtualTransfer();
  Future<Either> sendBankTransferData(BankParams params);
  Future<Either> deleteBankTransferData(int id);
  Future<Either> detailBankTransfer(int id);
  Future<Either> sendVirtualAccountData(VirtualAccountParams params);
}

class TransferVirtualServicesImpl extends TransferVirtualServices {
  @override
  Future<Either> getAllBankTransfer() async {
    // TODO: implement getAllBankTransfer
    try {
      var response = await sl<DioClient>().get(
        ApiUrl.getAllListBank,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data ?? "Something Gone Wrong!");
    }
  }

  @override
  Future<Either> getAllVirtualTransfer() async {
    // TODO: implement getAllVirtualTransfer
    try {
      var response = await sl<DioClient>().get(
        ApiUrl.getDataVirtualAccount,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data ?? "Something Gone Wrong!");
    }
  }

  @override
  Future<Either> sendBankTransferData(BankParams params) async {
    // TODO: implement sendBankTransferData
    try {
      var response = await sl<DioClient>().post(
        ApiUrl.createBankTransfer,
        data: params.toMap(),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data ?? "Something Gone Wrong!");
    }
  }

  @override
  Future<Either> deleteBankTransferData(int id) async {
    // TODO: implement deleteBankTransferData
    try {
      var response = await sl<DioClient>().delete(
        "${ApiUrl.deleteTransferBank}$id",
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response?.data ?? "Something Gone Wrong!");
    }
  }

  @override
  Future<Either> detailBankTransfer(int id) async {
    // TODO: implement detailBankTransfer
    try {
      var response = await sl<DioClient>().delete(
        "${ApiUrl.getListBankById}$id",
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response?.data ?? "Something Gone Wrong!");
    }
  }

  @override
  Future<Either> sendVirtualAccountData(VirtualAccountParams params) async {
    // TODO: implement sendVirtualAccountData
    try {
      var response = await sl<DioClient>().post(
        ApiUrl.createVirtualAccount,
        data: params.toMap(),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data ?? "Something Gone Wrong!");
    }
  }
}
