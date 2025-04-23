import 'package:dartz/dartz.dart';

abstract class TransferVirtualRepository {
  Future<Either> getAllBankTransfer();
  Future<Either> getAllVirtualTransfer();
}
