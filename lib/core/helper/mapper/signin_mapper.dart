import 'package:SummitDocs/Data/signin/models/signin_models.dart';

import '../../../Domain/signin/entity/signin_entity.dart';

class SigninMapper {
  static SigninEntity toEntity(SigninModels signin) {
    return SigninEntity(
      name: signin.user?.name,
      username: signin.user?.username,
      role: signin.user?.role,
    );
  }
}
