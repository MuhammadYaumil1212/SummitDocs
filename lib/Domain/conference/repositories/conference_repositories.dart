import 'package:dartz/dartz.dart';

abstract class ConferenceRepositories {
  //ICODSA
  Future<Either> icodsaLoa();
  Future<Either> icodsaInvoice();
  Future<Either> icodsaReceipt();

  //ICICYTA
  Future<Either> icicytaLoa();
  Future<Either> icicytaInvoice();
  Future<Either> icicytaReceipt();
}
