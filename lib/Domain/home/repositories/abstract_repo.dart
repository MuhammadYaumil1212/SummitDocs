import 'package:dartz/dartz.dart';

abstract class AbstractRepo {
  Future<Either> getBooks();
}
