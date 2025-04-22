import 'package:SummitDocs/Data/home/sources/homes_services.dart';
import 'package:SummitDocs/Domain/home/repositories/home_repository.dart';
import 'package:SummitDocs/core/helper/mapper/invoice_icodsa_mapper.dart';
import 'package:dartz/dartz.dart';

import '../../../service_locator.dart';

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
        print("data invoice : ${data}");
        final dataMapper = List.from(data).map((item) {
          InvoiceIcodsaMapper.toEntity(item);
        }).toList();
        return Right(dataMapper);
      },
    );
  }

  @override
  Future<Either> getHistoryLOA() async {
    // TODO: implement getHistoryLOA
    var result = await sl<HomesServices>().getHistoryLOA();
    return result.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        return Right(data);
      },
    );
  }
}
