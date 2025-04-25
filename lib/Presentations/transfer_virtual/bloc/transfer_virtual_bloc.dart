import 'package:SummitDocs/Data/transfer_virtual/models/bank_params.dart';
import 'package:SummitDocs/Domain/transfer_virtual/entity/transfer_virtual_entity.dart';
import 'package:SummitDocs/Domain/transfer_virtual/usecase/save_bank_transfer_usecase.dart';
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
  }
}
