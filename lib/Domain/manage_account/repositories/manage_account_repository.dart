import 'package:dartz/dartz.dart';

abstract class ManageAccountRepository {
  Future<Either> getAllUser();
}
