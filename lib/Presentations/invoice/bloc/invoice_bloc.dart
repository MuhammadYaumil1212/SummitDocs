import 'package:SummitDocs/Data/invoice/models/update_invoice_params.dart';
import 'package:SummitDocs/Domain/invoice/usecase/get_all_invoice_icicyta_usecase.dart';
import 'package:SummitDocs/Domain/invoice/usecase/update_invoice_icicyta_usecase.dart';
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

    on<SubmitUpdateInvoiceIcicyta>((event, emit) async {
      emit(UpdateInvoiceIcicytaLoadingState(true));
      print("amount String : ${event.amount}");
      final response = await sl<UpdateInvoiceIcicytaUsecase>().call(
        params: UpdateInvoiceParams(
          email: event.email,
          id: event.id,
          amount: event.amount,
          status: event.status,
          authorType: event.authorType,
          bankTransferId: event.bankTransferId,
          dateOfIssue: event.dateOfIssue,
          institution: event.institution,
          memberType: event.memberType,
          presentationType: event.presentationType,
          virtualAccountId: event.virtualAccountId,
        ),
      );
      response.fold(
        (error) {
          emit(UpdateInvoiceIcicytaLoadingState(false));
          final List<String> errorMessages = [];
          if (error != null && error is Map) {
            error.forEach((key, value) {
              if (value is List) {
                for (var msg in value) {
                  if (msg is String) {
                    errorMessages.add(msg);
                  }
                }
              }
            });
          } else {
            errorMessages.add('Terjadi Kesalahan! Silahkan coba lagi.');
          }
          emit(FailedUpdateInvoiceIcicyta(errorMessages));
        },
        (data) {
          emit(UpdateInvoiceIcicytaLoadingState(false));
          emit(UpdateInvoiceIcicytaState(data));
        },
      );
    });
  }
}
