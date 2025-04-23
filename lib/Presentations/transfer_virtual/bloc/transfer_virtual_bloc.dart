import 'package:SummitDocs/Domain/transfer_virtual/entity/transfer_virtual_entity.dart';
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
  }
}
