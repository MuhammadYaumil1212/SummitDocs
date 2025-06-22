import 'package:SummitDocs/Data/invoice/models/update_invoice_params.dart';
import 'package:SummitDocs/Domain/home/usecases/get_invoice_icodsa_usecase.dart';
import 'package:SummitDocs/Domain/invoice/usecase/get_all_invoice_icicyta_usecase.dart';
import 'package:SummitDocs/Domain/invoice/usecase/get_all_invoice_icodsa_usecase.dart';
import 'package:SummitDocs/Domain/invoice/usecase/update_invoice_icicyta_usecase.dart';
import 'package:SummitDocs/Domain/invoice/usecase/update_invoice_icodsa_usecase.dart';
import 'package:SummitDocs/Domain/transfer_virtual/usecase/get_transfer_virtual_account_usecase.dart';
import 'package:SummitDocs/Presentations/transfer_virtual/bloc/transfer_virtual_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../Domain/home/entities/invoice_entity.dart';
import '../../../Domain/transfer_virtual/entity/account_virtual_entity.dart';
import '../../../Domain/transfer_virtual/entity/transfer_virtual_entity.dart';
import '../../../Domain/transfer_virtual/usecase/transfer_virtual_usecase.dart';
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

    on<GetInvoiceIcodsaListEvent>((event, emit) async {
      emit(LoadingState(isLoading: true));
      final response = await sl<GetAllInvoiceIcodsaUsecase>().call();
      response.fold((error) {
        emit(LoadingState(isLoading: false));
        emit(FailedState(error));
      }, (data) {
        emit(LoadingState(isLoading: false));
        emit(SuccessState(data));
      });
    });

    on<SubmitUpdateInvoiceIcodsa>((event, emit) async {
      emit(UpdateInvoiceIcodsaLoadingState(isLoading: true));
      final response = await sl<UpdateInvoiceIcodsaUsecase>().call(
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
      ));
      response.fold(
        (error) {
          emit(UpdateInvoiceIcodsaLoadingState(isLoading: false));
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
          emit(FailedUpdateInvoiceIcodsa(errorMessages));
        },
        (data) {
          emit(UpdateInvoiceIcodsaLoadingState(isLoading: false));
          emit(SuccessUpdateInvoiceIcodsa(data));
        },
      );
    });

    on<LoadVirtualAccount>((event, emit) async {
      emit(LoadingState(isLoading: true));
      final virtualAccount =
          await sl<GetTransferVirtualAccountUsecase>().call();

      virtualAccount.fold((error) {
        emit(LoadingState(isLoading: false));
      }, (data) {
        emit(LoadingState(isLoading: false));
        emit(SuccessVirtualAccount(accountVirtual: data));
      });
    });

    on<LoadTransferBankVirtual>((event, emit) async {
      emit(LoadingState(isLoading: true));
      var transferVirtual = await sl<TransferVirtualUsecase>().call();
      transferVirtual.fold((error) {
        emit(LoadingState(isLoading: false));
      }, (data) {
        emit(LoadingState(isLoading: false));
        emit(SuccessTransfer(transferVirtual: data));
      });
    });
  }
}
