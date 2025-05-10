import 'package:SummitDocs/Data/home/sources/homes_services.dart';
import 'package:SummitDocs/Domain/home/repositories/home_repository.dart';
import 'package:SummitDocs/core/helper/mapper/invoice_mapper.dart';
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
          InvoiceMapper.toEntityIcodsa(item);
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
        return Right(data);
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
          print("data mapper : ${model.createdAt}");
          return InvoiceMapper.toEntity(model);
        }).toList();
        return Right(dataMapper);
      },
    );
  }

  @override
  Future<Either> getHistoryIcicytaLOA() {
    // TODO: implement getHistoryIcicytaLOA
    throw UnimplementedError();
  }
}
