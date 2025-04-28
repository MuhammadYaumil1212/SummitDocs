import 'package:SummitDocs/Data/transfer_virtual/models/bank_params.dart';
import 'package:SummitDocs/Data/transfer_virtual/models/virtual_account_params.dart';
import 'package:SummitDocs/Domain/transfer_virtual/entity/account_virtual_entity.dart';
import 'package:SummitDocs/Domain/transfer_virtual/entity/transfer_virtual_entity.dart';
import 'package:SummitDocs/Domain/transfer_virtual/usecase/delete_bank_transfer.dart';
import 'package:SummitDocs/Domain/transfer_virtual/usecase/detail_bank_transfer_usecase.dart';
import 'package:SummitDocs/Domain/transfer_virtual/usecase/get_transfer_virtual_account_usecase.dart';
import 'package:SummitDocs/Domain/transfer_virtual/usecase/save_bank_transfer_usecase.dart';
import 'package:SummitDocs/Domain/transfer_virtual/usecase/save_virtual_account_usecase.dart';
import 'package:SummitDocs/Domain/transfer_virtual/usecase/transfer_virtual_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../service_locator.dart';

part 'transfer_virtual_event.dart';
part 'transfer_virtual_state.dart';

class TransferVirtualBloc
    extends Bloc<TransferVirtualEvent, TransferVirtualState> {
  TransferVirtualBloc() : super(TransferVirtualInitial()) {
    on<TransferVirtualEvent>((event, emit) async {});
    on<LoadTransferBankVirtual>((event, emit) async {
      emit(LoadingTransfer(isLoading: true));
      var transferVirtual = await sl<TransferVirtualUsecase>().call();
      transferVirtual.fold((error) {
        emit(LoadingTransfer(isLoading: false));
        emit(FailedTransfer(errorMessage: error));
      }, (data) {
        emit(LoadingTransfer(isLoading: false));
        emit(SuccessTransfer(transferVirtual: data));
      });
    });
    on<SendBankTransferData>((event, emit) async {
      emit(LoadingTransfer(isLoading: true));

      var sendBank = await sl<SaveBankTransferUsecase>().call(
        params: BankParams(
          namaBank: event.namaBank,
          swiftCode: event.swiftCode,
          receipientName: event.receipientName,
          beneficiaryBankAccountNo: event.beneficiaryBankAccountNo,
          bankBranch: event.bankBranch,
          bankAddress: event.bankAddress,
          city: event.city,
          country: event.country,
        ),
      );
      sendBank.fold(
        (error) {
          emit(LoadingTransfer(isLoading: false));
          final List<String> errorMessages = [];
          error.forEach((key, value) {
            for (var entry in error.entries) {
              final value = entry.value;
              if (value is List) {
                for (var msg in value) {
                  if (msg is String) {
                    errorMessages.add(msg);
                  }
                }
              }
            }
          });
          emit(FailedSendData(errorMessage: errorMessages));
        },
        (data) {
          emit(LoadingTransfer(isLoading: false));
          emit(SuccessSendData(successMessage: data));
        },
      );
    });
    on<DeleteTransferData>((event, emit) async {
      emit(LoadingTransfer(isLoading: true));
      final delete =
          await sl<DeleteBankTransferUsecase>().call(params: event.id);
      delete.fold((error) {
        emit(LoadingTransfer(isLoading: false));
        emit(FailedDeleteData(errorMessage: error));
      }, (data) {
        emit(LoadingTransfer(isLoading: false));
        emit(SuccessDeleteData(successMessage: data.message));
      });
    });
    on<LoadDetailBank>((event, emit) async {
      emit(LoadingDetailBank(isLoading: true));
      final detailBank =
          await sl<DetailBankTransferUsecase>().call(params: event.id);
      detailBank.fold((error) {
        emit(LoadingDetailBank(isLoading: false));
        emit(DetailBankFailed(errorMessage: error));
      }, (data) {
        emit(LoadingDetailBank(isLoading: false));
        emit(DetailBankLoaded(detailBankEntity: data));
      });
    });
    on<LoadVirtualAccount>((event, emit) async {
      emit(LoadingVirtualAccount(isLoading: true));
      final virtualAccount =
          await sl<GetTransferVirtualAccountUsecase>().call();

      virtualAccount.fold((error) {
        emit(LoadingVirtualAccount(isLoading: false));
        emit(FailedVirtualAccount(errorMessage: error));
      }, (data) {
        emit(LoadingVirtualAccount(isLoading: false));
        emit(SuccessVirtualAccount(accountVirtual: data));
      });
    });
    on<SendVirtualAccount>((event, emit) async {
      emit(LoadingVirtualAccount(isLoading: true));
      final sendVirtualAccount = await sl<SaveVirtualAccountUsecase>().call(
        params: VirtualAccountParams(
          noVirtualAccount: event.noVirtualAccount,
          accountHolderName: event.accountHolderName,
          bankName: event.bankName,
          bankBranch: event.bankBranch,
        ),
      );
      sendVirtualAccount.fold((error) {
        emit(LoadingVirtualAccount(isLoading: false));
        final List<String> errorMessages = [];
        error.forEach((key, value) {
          for (var entry in error.entries) {
            final value = entry.value;
            if (value is List) {
              for (var msg in value) {
                if (msg is String) {
                  errorMessages.add(msg);
                }
              }
            }
          }
        });
        emit(FailedSendVirtualAccount(errorMessage: errorMessages));
      }, (data) {
        emit(LoadingVirtualAccount(isLoading: false));
        emit(SuccessSendVirtualAccount(successMessage: data));
      });
    });
  }
}
