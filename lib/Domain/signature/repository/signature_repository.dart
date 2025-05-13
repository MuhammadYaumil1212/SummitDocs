import 'package:SummitDocs/Data/settings/models/signature_params.dart';
import 'package:dartz/dartz.dart';

import '../../../Data/signature/models/signature_params_admin.dart';

abstract class SignatureRepository {
  Future<Either> getSignatureList();
  Future<Either> getSignatureListById(int id);
  Future<Either> createSignatureList();
  Future<Either> updateSignatureList(SignatureParamsAdmin params);
  Future<Either> deleteSignature(int id);
}
