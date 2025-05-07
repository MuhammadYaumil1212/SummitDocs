import 'package:SummitDocs/commons/constants/api_url.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/network/dio_client.dart';
import '../../../service_locator.dart';
import '../models/update_loa_params.dart';

abstract class LoaServices {
  //icicyta
  Future<Either> updateLOA(UpdateLoaParams params);
  Future<Either> createLOA(UpdateLoaParams params);
  Future<Either> getAllLoa();

  //icodsa
  Future<Either> getAllIcodsaLoa();
  Future<Either> updateIcodsaLOA(UpdateLoaParams params);
  Future<Either> createIcodsaLOA(UpdateLoaParams params);
}

class LoaServicesImpl extends LoaServices {
  @override
  Future<Either> updateLOA(UpdateLoaParams params) async {
    // TODO: implement updateLOA
    try {
      var response = await sl<DioClient>().put(
        "",
        data: params.toMap(),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data ?? "Something Gone Wrong!");
    }
  }

  @override
  Future<Either> getAllLoa() async {
    // TODO: implement getAllLoa
    try {
      var response = await sl<DioClient>().get(ApiUrl.getDocsLOA);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data ?? "Something Gone Wrong!");
    }
  }

  @override
  Future<Either> createLOA(UpdateLoaParams params) async {
    // TODO: implement createLOA
    try {
      var response = await sl<DioClient>().post(
        ApiUrl.postDataLoaIcicyta,
        data: params.toMap(),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data ?? "Something Gone Wrong!");
    }
  }

  @override
  Future<Either> createIcodsaLOA(UpdateLoaParams params) {
    // TODO: implement createIcodsaLOA
    throw UnimplementedError();
  }

  @override
  Future<Either> getAllIcodsaLoa() async {
    // TODO: implement getAllIcodsaLoa
    try {
      var response = await sl<DioClient>().get(ApiUrl.getDocsIcodsaLoa);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data ?? "Something Gone Wrong!");
    }
  }

  @override
  Future<Either> updateIcodsaLOA(UpdateLoaParams params) {
    // TODO: implement updateIcodsaLOA
    throw UnimplementedError();
  }
}
