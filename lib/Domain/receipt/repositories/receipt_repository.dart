import 'package:dartz/dartz.dart';

abstract class ReceiptRepository {
  Future<Either> getAllReceiptsIcicyta();
  Future<Either> getAllReceiptsIcodsa();
}
