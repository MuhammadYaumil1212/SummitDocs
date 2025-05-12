import 'package:dartz/dartz.dart';

abstract class SignatureRepository {
  Future<Either> getSignatureList();
  Future<Either> getSignatureListById(int id);
  Future<Either> createSignatureList();
  Future<Either> updateSignatureList();
  Future<Either> deleteSignature(int id);
}
