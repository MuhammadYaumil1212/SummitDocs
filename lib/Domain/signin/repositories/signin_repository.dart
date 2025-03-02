import 'package:SummitDocs/Data/signin/models/signinParams.dart';
import 'package:dartz/dartz.dart';

abstract class SigninRepository {
  Future<Either> signin(SigninParams params);
}
