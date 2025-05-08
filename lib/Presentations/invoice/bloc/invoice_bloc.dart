import 'package:SummitDocs/Domain/invoice/usecase/get_all_invoice_icicyta_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../Domain/home/entities/invoice_entity.dart';
import '../../../service_locator.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  InvoiceBloc() : super(InvoiceInitial()) {
    on<InvoiceEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetInvoiceIcicytaListEvent>((event, emit) async {
      emit(LoadingState(isLoading: true));
      final response = await sl<GetAllInvoiceIcicytaUsecase>().call();
      response.fold((error) {
        emit(LoadingState(isLoading: false));
        emit(FailedState(error));
      }, (data) {
        emit(LoadingState(isLoading: false));
        emit(SuccessState(data));
      });
    });
  }
}
