import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'transfer_virtual_event.dart';
part 'transfer_virtual_state.dart';

class TransferVirtualBloc
    extends Bloc<TransferVirtualEvent, TransferVirtualState> {
  TransferVirtualBloc() : super(TransferVirtualInitial()) {
    on<TransferVirtualEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
