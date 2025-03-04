import 'package:dartz/dartz.dart';

abstract class ConferenceService {
  //ICODSA
  Future<Either> icodsaLoa();
  Future<Either> icodsaInvoice();
  Future<Either> icodsaReceipt();

  //ICICYTA
  Future<Either> icicytaLoa();
  Future<Either> icicytaInvoice();
  Future<Either> icicytaReceipt();
}

class ConferenceServiceImpl extends ConferenceService {
  @override
  Future<Either> icodsaInvoice() {
    // TODO: implement icodsaInvoice
    throw UnimplementedError();
  }

  @override
  Future<Either> icodsaLoa() {
    // TODO: implement icodsaLoa
    throw UnimplementedError();
  }

  @override
  Future<Either> icodsaReceipt() {
    // TODO: implement icodsaReceipt
    throw UnimplementedError();
  }

  @override
  Future<Either> icicytaInvoice() {
    // TODO: implement icicytaInvoice
    throw UnimplementedError();
  }

  @override
  Future<Either> icicytaLoa() {
    // TODO: implement icicytaLoa
    throw UnimplementedError();
  }

  @override
  Future<Either> icicytaReceipt() {
    // TODO: implement icicytaReceipt
    throw UnimplementedError();
  }
}
