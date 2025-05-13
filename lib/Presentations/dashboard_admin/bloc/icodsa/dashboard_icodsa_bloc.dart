import 'package:SummitDocs/Domain/receipt/entity/receipt_entity.dart';
import 'package:SummitDocs/Domain/receipt/repositories/receipt_repository.dart';
import 'package:SummitDocs/Domain/receipt/usecase/get_all_receipt_icodsa_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../Domain/LoA/entity/loa_entity.dart';
import '../../../../Domain/home/entities/LoaEntity.dart';
import '../../../../Domain/home/entities/invoice_entity.dart';
import '../../../../Domain/home/repositories/home_repository.dart';
import '../../../../service_locator.dart';

part 'dashboard_icodsa_event.dart';
part 'dashboard_icodsa_state.dart';

class DashboardIcodsaBloc
    extends Bloc<DashboardIcodsaEvent, DashboardIcodsaState> {
  DashboardIcodsaBloc() : super(DashboardIcodsaInitial()) {
    on<DashboardIcodsaEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetHistoryInvoiceIcodsa>((event, emit) async {
      emit(LoadingTableInvoice(isLoading: true));
      final response = await sl<HomeRepository>().getHistoryIcodsaInvoice();
      response.fold((error) {
        emit(LoadingTableInvoice(isLoading: false));
        emit(FailedTableInvoice(message: error));
      }, (data) {
        emit(LoadingTableInvoice(isLoading: false));
        emit(SuccessTableInvoice(data: data));
      });
    });
    on<GetHistoryLoAIcodsa>((event, emit) async {
      emit(LoadingTableLoa(isLoading: true));
      final response = await sl<HomeRepository>().getHistoryIcodsaLOA();
      response.fold((error) {
        emit(LoadingTableLoa(isLoading: false));
        emit(FailedTableLoa(message: error));
      }, (data) {
        emit(LoadingTableLoa(isLoading: false));
        emit(SuccessTableLoa(data: data));
      });
    });

    on<GetHistoryReceiptIcodsa>((event, emit) async {
      emit(LoadingTableReceipt(isLoading: true));
      final response = await sl<ReceiptRepository>().getAllReceiptsIcodsa();
      response.fold((error) {
        emit(LoadingTableReceipt(isLoading: false));
        emit(FailedTableReceipt(message: error));
      }, (data) {
        emit(LoadingTableReceipt(isLoading: false));
        emit(SuccessTableReceipt(data: data));
      });
    });
  }
}
