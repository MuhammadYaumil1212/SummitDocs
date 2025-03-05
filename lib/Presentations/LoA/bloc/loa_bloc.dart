import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'loa_event.dart';
part 'loa_state.dart';

class LoaBloc extends Bloc<LoaEvent, LoaState> {
  LoaBloc() : super(LoaInitial()) {
    on<LoaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
