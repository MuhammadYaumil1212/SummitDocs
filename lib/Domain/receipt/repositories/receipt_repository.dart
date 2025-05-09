import 'package:dartz/dartz.dart';

abstract class ReceiptRepository {
  Future<Either> getAllReceipts();
}
