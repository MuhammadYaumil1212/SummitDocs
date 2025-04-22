import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either> getHistoryLOA();
  Future<Either> getHistoryIcodsaInvoice();
}
