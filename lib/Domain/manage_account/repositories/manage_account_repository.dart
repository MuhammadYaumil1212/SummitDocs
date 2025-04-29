import 'package:SummitDocs/Data/manage_account/models/create_account_params.dart';
import 'package:dartz/dartz.dart';

abstract class ManageAccountRepository {
  Future<Either> getAllUser();
  Future<Either> createAccount(CreateAccountParams params);
}
