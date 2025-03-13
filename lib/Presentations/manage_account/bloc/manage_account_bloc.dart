import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'manage_account_event.dart';
part 'manage_account_state.dart';

class ManageAccountBloc extends Bloc<ManageAccountEvent, ManageAccountState> {
  ManageAccountBloc() : super(ManageAccountInitial()) {
    on<ManageAccountEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
