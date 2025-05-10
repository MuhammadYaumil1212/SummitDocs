import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either> getHistoryIcodsaLOA();
  Future<Either> getHistoryIcodsaInvoice();

  Future<Either> getHistoryIcicytaLOA();
  Future<Either> getHistoryIcicytaInvoice();
}
