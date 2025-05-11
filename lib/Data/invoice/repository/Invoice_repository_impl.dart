import 'package:SummitDocs/Data/home/models/invoice_model.dart';
import 'package:SummitDocs/Data/invoice/models/update_invoice_params.dart';
import 'package:SummitDocs/Data/invoice/sources/invoice_services.dart';
import 'package:SummitDocs/Domain/invoice/repository/invoice_repository.dart';
import 'package:SummitDocs/core/helper/mapper/invoice_mapper.dart';
import 'package:dartz/dartz.dart';

import '../../../service_locator.dart';

class InvoiceRepositoryImpl extends InvoiceRepository {
  @override
  Future<Either> getInvoiceIcicytaList() async {
    // TODO: implement getInvoiceIcicytaList
    final response = await sl<InvoiceServices>().getAllListInvoiceIcicyta();
    return response.fold((error) {
      return Left(error['message']);
    }, (data) {
      final dataMapper = List.from(data).map((element) {
        final model = InvoiceModel.fromJson(element);
        return InvoiceMapper.toEntity(model);
      }).toList();
      return Right(dataMapper);
    });
  }

  @override
  Future<Either> updateInvoiceIcicyta(UpdateInvoiceParams params) async {
    // TODO: implement updateInvoiceIcicyta
    final response = await sl<InvoiceServices>().updateInvoiceIcicyta(params);
    return response.fold(
      (error) {
        return Left(error['errors'] ?? error['message']);
      },
      (data) {
        return Right(data['message']);
      },
    );
  }

  @override
  Future<Either> getInvoiceIcodsaList() async {
    final response = await sl<InvoiceServices>().getInvoiceIcodsaList();
    return response.fold(
      (error) {
        print("error get invoice : $error");

        final messages = error is Map ? error['messages'] : null;

        String errorMessage;
        if (messages is List) {
          errorMessage = messages.join(', ');
        } else if (messages is String) {
          errorMessage = messages;
        } else {
          errorMessage = error.toString();
        }

        return Left(errorMessage);
      },
      (data) {
        // Aman convert list data
        final dataMapper = List.from(data).map((element) {
          final model = InvoiceModel.fromJson(element);
          return InvoiceMapper.toEntity(model);
        }).toList();
        return Right(dataMapper);
      },
    );
  }

  @override
  Future<Either> updateInvoiceIcodsa(UpdateInvoiceParams params) async {
    final response = await sl<InvoiceServices>().updateInvoiceIcodsa(params);
    return response.fold(
      (error) {
        print("error ubah data : $error");
        final errors = error is Map ? error['errors'] : null;

        String errorMessage;
        if (errors is List) {
          errorMessage = errors.join(', ');
        } else if (errors is String) {
          errorMessage = errors;
        } else {
          errorMessage = error.toString();
        }

        return Left(errorMessage);
      },
      (data) {
        return Right(data['message']);
      },
    );
  }
}
