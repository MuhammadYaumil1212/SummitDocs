import 'package:SummitDocs/Domain/receipt/usecase/get_all_receipt_icicyta_usecase.dart';
import 'package:SummitDocs/Domain/receipt/usecase/get_all_receipt_icodsa_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../Domain/receipt/entity/receipt_entity.dart';
import '../../../service_locator.dart';

part 'receipt_event.dart';
part 'receipt_state.dart';

class ReceiptBloc extends Bloc<ReceiptEvent, ReceiptState> {
  ReceiptBloc() : super(ReceiptInitial()) {
    on<ReceiptEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetAllReceiptIcicytaEvent>((event, emit) async {
      emit(LoadingState(true));
      final response = await sl<GetAllReceiptIcicytaUsecase>().call();
      response.fold((error) {
        emit(LoadingState(false));
        emit(FailedTable(error));
      }, (data) {
        emit(LoadingState(false));
        emit(SuccessTable(data));
      });
    });
    on<GetAllReceiptIcodsaEvent>((event, emit) async {
      emit(LoadingState(true));
      final response = await sl<GetAllReceiptIcodsaUsecase>().call();
      response.fold((error) {
        emit(LoadingState(false));
        emit(FailedTable(error));
      }, (data) {
        emit(LoadingState(false));
        emit(SuccessTable(data));
      });
    });
  }
}
