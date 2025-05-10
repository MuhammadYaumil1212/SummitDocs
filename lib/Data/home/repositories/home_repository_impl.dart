import 'package:SummitDocs/Data/home/models/loa_model.dart';
import 'package:SummitDocs/Data/home/sources/homes_services.dart';
import 'package:SummitDocs/Domain/home/repositories/home_repository.dart';
import 'package:SummitDocs/core/helper/mapper/invoice_mapper.dart';
import 'package:SummitDocs/core/helper/mapper/loa_mapper_home.dart';
import 'package:dartz/dartz.dart';

import '../../../service_locator.dart';
import '../models/invoice_model.dart';

class HomeRepositoryImpl extends HomeRepository {
  @override
  Future<Either> getHistoryIcodsaInvoice() async {
    // TODO: implement getHistoryInvoice
    var result = await sl<HomesServices>().getHistoryIcodsaInvoice();
    return result.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        final dataMapper = List.from(data).map((item) {
          final model = InvoiceModel.fromJson(item);
          return InvoiceMapper.toEntityIcodsa(model);
        }).toList();
        return Right(dataMapper);
      },
    );
  }

  @override
  Future<Either> getHistoryIcodsaLOA() async {
    // TODO: implement getHistoryLOA
    final response = await sl<HomesServices>().getHistoryLOA();
    return response.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        final dataMapper = List.from(data).map((item) {
          final model = LoaModel.fromJson(item);
          return LoaMapperHome.toEntity(model);
        }).toList();
        return Right(dataMapper);
      },
    );
  }

  @override
  Future<Either> getHistoryIcicytaInvoice() async {
    // TODO: implement getHistoryIcicytaInvoice
    final response = await sl<HomesServices>().getHistoryIcicytaInvoice();
    return response.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        final dataMapper = List.from(data).map((item) {
          final model = InvoiceModel.fromJson(item);
          return InvoiceMapper.toEntity(model);
        }).toList();
        return Right(dataMapper);
      },
    );
  }

  @override
  Future<Either> getHistoryIcicytaLOA() async {
    // TODO: implement getHistoryIcicytaLOA
    final response = await sl<HomesServices>().getHistoryIcicytaLOA();
    return response.fold((error) {
      return Left(error['message']);
    }, (data) {
      final dataMapper = List.from(data).map((item) {
        final model = LoaModel.fromJson(item);
        return LoaMapperHome.toEntity(model);
      });
      return Right(dataMapper);
    });
  }
}
