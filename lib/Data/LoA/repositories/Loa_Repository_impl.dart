import 'package:SummitDocs/Data/LoA/models/load_model.dart';
import 'package:SummitDocs/Data/LoA/models/update_loa_params.dart';
import 'package:SummitDocs/Data/LoA/sources/Loa_services.dart';
import 'package:SummitDocs/Domain/LoA/repositories/Loa_repository.dart';
import 'package:SummitDocs/core/helper/mapper/loa_mapper.dart';
import 'package:dartz/dartz.dart';

import '../../../service_locator.dart';

class LoaRepositoryImpl extends LoaRepository {
  @override
  Future<Either> updateLOA(UpdateLoaParams params) async {
    // TODO: implement updateLOA
    final response = await sl<LoaServices>().updateLOA(params);
    return response.fold((error) {
      return Left(error);
    }, (data) {
      return Right(data['message']);
    });
  }

  @override
  Future<Either> getAllLoa() async {
    // TODO: implement getAllLoa
    final response = await sl<LoaServices>().getAllLoa();
    return response.fold((error) {
      return Left(error['messages']);
    }, (data) {
      final dataMapper = List.from(data).map((element) {
        final model = LoaModel.fromJson(element);
        return LoaMapper.toEntity(model);
      }).toList();
      return Right(dataMapper);
    });
  }

  @override
  Future<Either> createLOA(UpdateLoaParams params) async {
    // TODO: implement createLOA
    final response = await sl<LoaServices>().createLOA(params);
    return response.fold((error) {
      return Left(error['errors']);
    }, (data) {
      return Right(data['message']);
    });
  }

  @override
  Future<Either> createIcodsaLOA(UpdateLoaParams params) {
    // TODO: implement createIcodsaLOA
    throw UnimplementedError();
  }

  @override
  Future<Either> getAllIcodsaLoa() async {
    // TODO: implement getAllIcodsaLoa
    final response = await sl<LoaServices>().getAllLoa();
    return response.fold((error) {
      return Left(error['messages']);
    }, (data) {
      final dataMapper = List.from(data).map((element) {
        final model = LoaModel.fromJson(element);
        return LoaMapper.toEntity(model);
      }).toList();
      return Right(dataMapper);
    });
  }

  @override
  Future<Either> updateIcodsaLOA(UpdateLoaParams params) {
    // TODO: implement updateIcodsaLOA
    throw UnimplementedError();
  }
}
