import 'package:SummitDocs/Data/manage_account/models/create_account_params.dart';
import 'package:SummitDocs/Data/manage_account/models/user_model.dart';
import 'package:SummitDocs/Domain/manage_account/repositories/manage_account_repository.dart';
import 'package:SummitDocs/core/helper/mapper/manage_account_mapper.dart';
import 'package:dartz/dartz.dart';

import '../../../service_locator.dart';
import '../models/create_account_model.dart';
import '../sources/manage_account_services.dart';

class ManageAccountRepositoryImpl extends ManageAccountRepository {
  @override
  Future<Either> getAllUser() async {
    // TODO: implement getAllUser
    final response = await sl<ManageAccountServices>().getAllUser();
    return response.fold((error) {
      return Left(error ?? "Something Gone Wrong!");
    }, (data) {
      final dataMapper = List.from(data['admin']).map((element) {
        final model = UserModel.fromJson(element);
        return ManageAccountMapper.toEntity(model);
      }).toList();
      return Right(dataMapper);
    });
  }

  @override
  Future<Either> createAccount(CreateAccountParams params) async {
    // TODO: implement createAdmin
    final response = await sl<ManageAccountServices>().createAccount(params);
    return response.fold((error) {
      return Left(error ?? "Something Gone Wrong!");
    }, (data) {
      final dataMapper = ManageAccountMapper.toEntityCreateAccount(
        CreateAccountModel.fromJson(data),
      );
      return Right(dataMapper.message);
    });
  }

  @override
  Future<Either> deleteAccount(int params) async {
    // TODO: implement deleteAccount
    final response = await sl<ManageAccountServices>().deleteAccount(params);
    return response.fold((error) {
      return Left(error ?? "Something Gone Wrong!");
    }, (data) {
      print("data delete : ${data}");
      return Right(data['message']);
    });
  }
}
