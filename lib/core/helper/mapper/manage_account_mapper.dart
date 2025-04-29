import 'package:SummitDocs/Data/manage_account/models/create_account_model.dart';
import 'package:SummitDocs/Data/manage_account/models/user_model.dart';
import 'package:SummitDocs/Domain/manage_account/entity/create_account_entity.dart';
import 'package:SummitDocs/Domain/manage_account/entity/user_entity.dart';

class ManageAccountMapper {
  static UserEntity toEntity(UserModel userModel) {
    return UserEntity(
      id: userModel.id,
      name: userModel.name,
      roleId: userModel.roleId,
      email: userModel.email,
      username: userModel.username,
      createdAt: DateTime.tryParse(userModel.createdAt ?? ''),
      updatedAt: DateTime.tryParse(userModel.updatedAt ?? ''),
    );
  }

  static CreateAccountEntity toEntityCreateAccount(
      CreateAccountModel createAccountModel) {
    return CreateAccountEntity(
      message: createAccountModel.message,
    );
  }
}
