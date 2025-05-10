import 'package:SummitDocs/Domain/home/entities/LoaEntity.dart';
import 'package:SummitDocs/Domain/home/entities/invoice_entity.dart';
import 'package:SummitDocs/Domain/home/usecases/get_invoice_icicyta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../service_locator.dart';

part 'dashboard_icycita_event.dart';
part 'dashboard_icycita_state.dart';

class DashboardIcycitaBloc
    extends Bloc<DashboardIcycitaEvent, DashboardIcycitaState> {
  DashboardIcycitaBloc() : super(DashboardIcycitaInitial()) {
    on<DashboardIcycitaEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetHistoryLOAIcicyta>((event, emit) {});
    on<GetHistoryInvoiceIcicyta>((event, emit) async {
      emit(LoadingTable(isLoading: true));
      final response = await sl<GetInvoiceIcicytaUsecase>().call();
      response.fold((error) {
        emit(LoadingTable(isLoading: false));
        emit(FailedTable(message: error));
      }, (data) {
        emit(LoadingTable(isLoading: false));
        emit(SuccessTable(data: data));
      });
    });
  }
}
