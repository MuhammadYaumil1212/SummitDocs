import 'dart:io';

import 'package:SummitDocs/Data/settings/models/signature_params.dart';
import 'package:SummitDocs/commons/constants/api_url.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/network/dio_client.dart';
import '../../../service_locator.dart';

abstract class SettingsServices {
  Future<Either> uploadSignature(SignatureParams params);
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
}
