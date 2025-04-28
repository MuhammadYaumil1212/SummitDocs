import 'package:SummitDocs/Data/transfer_virtual/models/account_virtual_model.dart';
import 'package:SummitDocs/Data/transfer_virtual/models/bank_params.dart';
import 'package:SummitDocs/Data/transfer_virtual/models/virtual_account_params.dart';
import 'package:dartz/dartz.dart';

abstract class TransferVirtualRepository {
  //transfer bank
  Future<Either> getAllBankTransfer();
  Future<Either> sendBankData(BankParams params);
  Future<Either> deleteBankData(int id);
  Future<Either> detailBankTransfer(int id);

  //transfer virtual account
  Future<Either> getAllVirtualAccountTransfer();
  Future<Either> sendVirtualAccountData(VirtualAccountParams params);
  Future<Either> deleteVirtualAccountData(int id);
}
