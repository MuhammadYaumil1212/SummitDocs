import 'package:SummitDocs/Data/transfer_virtual/models/bank_params.dart';
import 'package:dartz/dartz.dart';

abstract class TransferVirtualRepository {
  Future<Either> getAllBankTransfer();
  Future<Either> getAllVirtualTransfer();
  Future<Either> sendBankData(BankParams params);
  Future<Either> deleteBankData(int id);
}
