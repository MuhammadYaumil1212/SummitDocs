import 'dart:io';

import 'package:SummitDocs/Data/settings/models/new_password_params.dart';
import 'package:SummitDocs/Data/settings/models/signature_params.dart';
import 'package:SummitDocs/commons/constants/api_url.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/network/dio_client.dart';
import '../../../service_locator.dart';

abstract class SettingsServices {
  Future<Either> uploadSignature(SignatureParams params);
  Future<Either> resetPassword(NewPasswordParams params);
}

class SettingServicesImpl extends SettingsServices {
  @override
  Future<Either> uploadSignature(SignatureParams params) async {
    // TODO: implement uploadSignature
    try {
      final response = await sl<DioClient>().uploadFormData(
        url: ApiUrl.createSignature,
        formFields: params.toMap(),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data ?? "Something Gone Wrong!");
    }
  }

  @override
  Future<Either> resetPassword(NewPasswordParams params) async {
    // TODO: implement resetPassword
    try {
      final response = await sl<DioClient>().put(
        params.roleId == 1
            ? ApiUrl.updateAdmin + "${params.id}"
            : params.roleId == 2
                ? ApiUrl.updateicodsaAdmin + "${params.id}"
                : ApiUrl.updateicicytaAdmin + "${params.id}",
        data: params.toMap(),
      );
      return Right(response.data);
    } on DioException catch (e) {
      print("error services : ${e.response?.data ?? ""}");
      return Left(e.response?.data ?? "Something Gone Wrong!");
    }
  }
}
