import 'package:SummitDocs/Domain/LoA/entity/loa_entity.dart';
import 'package:SummitDocs/Domain/LoA/usecase/get_all_loa_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../Data/LoA/models/update_loa_params.dart';
import '../../../Domain/LoA/usecase/create_loa_usecase.dart';
import '../../../service_locator.dart';

part 'loa_event.dart';
part 'loa_state.dart';

class LoaBloc extends Bloc<LoaEvent, LoaState> {
  LoaBloc() : super(LoaInitial()) {
    on<LoaEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetAllLoaEvent>((event, emit) async {
      emit(LoadingState(isLoading: true));
      final response = await sl<GetAllLoaUsecase>().call();
      response.fold((error) {
        emit(LoadingState(isLoading: false));
        emit(FailedState(error));
      }, (data) {
        emit(LoadingState(isLoading: false));
        emit(SuccessState(data));
      });
    });
    on<GetAllIcodsaLoaEvent>((event, emit) async {
      print("Loaded");
    });

    on<CreateLoaEvent>((event, emit) async {
      emit(LoadingState(isLoading: true));
      final response = await sl<CreateLoaUsecase>().call(
        params: UpdateLoaParams(
          paperId: event.paperId,
          paperTitle: event.paperTitle,
          paperAuthors: event.paperAuthors,
          status: event.status,
          tempatTanggal: event.tempatTanggal,
          signatureId: event.signatureId,
        ),
      );
      response.fold((error) {
        emit(LoadingState(isLoading: false));
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
        emit(FailedState(errorMessages));
      }, (data) {
        emit(LoadingState(isLoading: false));
        emit(SuccessLoaCreate(data));
      });
    });
  }
}
