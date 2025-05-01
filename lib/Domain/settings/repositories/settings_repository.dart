import 'package:SummitDocs/Data/settings/models/new_password_params.dart';
import 'package:SummitDocs/Data/settings/models/signature_params.dart';
import 'package:dartz/dartz.dart';

abstract class SettingsRepository {
  Future<Either> createSignature(SignatureParams params);
  Future<Either> resetPassword(NewPasswordParams params);
}
