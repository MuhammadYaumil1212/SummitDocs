import 'package:SummitDocs/Data/settings/models/signature_params.dart';
import 'package:SummitDocs/Domain/signature/repository/signature_repository.dart';
import 'package:SummitDocs/core/helper/mapper/signature_mapper.dart';
import 'package:dartz/dartz.dart';

import '../../../service_locator.dart';
import '../models/signature_model.dart';
import '../models/signature_params_admin.dart';
import '../services/signature_services.dart';

class SignatureRepositoryImpl extends SignatureRepository {
  @override
  Future<Either> createSignatureList() {
    // TODO: implement createSignatureList
    throw UnimplementedError();
  }

  @override
  Future<Either> getSignatureList() async {
    // TODO: implement getSignatureList
    final response = await sl<SignatureServices>().getSignatureList();
    return response.fold((error) {
      return Left(error['messagge']);
    }, (data) {
      final dataMapper = List.from(data).map((element) {
        final model = SignatureModel.fromJson(element);
        return SignatureMapper.toEntity(model);
      }).toList();
      return Right(dataMapper);
    });
  }

  @override
  Future<Either> getSignatureListById(int id) {
    // TODO: implement getSignatureListById
    throw UnimplementedError();
  }

  @override
  Future<Either> updateSignatureList(SignatureParamsAdmin params) async {
    // TODO: implement updateSignatureList
    final response = await sl<SignatureServices>().updateSignature(params);
    return response.fold(
      (error) {
        print("error update signature: ${error}");
        return Left(error['errors']);
      },
      (data) {
        return Right(data['message']);
      },
    );
  }

  @override
  Future<Either> deleteSignature(int id) async {
    // TODO: implement deleteSignature
    final response = await sl<SignatureServices>().deleteSignature(id);
    return response.fold(
      (error) {
        return Left(error['message']);
      },
      (data) {
        return Right(data['message']);
      },
    );
  }
}
