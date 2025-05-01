import 'dart:io';

import 'package:SummitDocs/Data/settings/models/signature_params.dart';
import 'package:SummitDocs/Domain/settings/usecases/create_signature_usecase.dart';
import 'package:SummitDocs/core/helper/formatter/date_formatter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../service_locator.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<SettingsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CreateSignatureEvent>((event, emit) async {
      emit(LoadingState(isLoading: true));
      final result = await sl<CreateSignatureUsecase>().call(
        params: SignatureParams(
          signatureName: event.signatureName,
          signaturePosition: event.signaturePosition,
          createdDate: DateFormatter.parseFromString(event.createdDate),
          signatureFile: event.signatureFile,
        ),
      );
      result.fold(
        (error) {
          emit(LoadingState(isLoading: false));
          final List<String> errorMessages = [];
          if (error != null && error is Map<String, dynamic>) {
            error.forEach((key, value) {
              if (value is List) {
                for (var msg in value) {
                  if (msg is String) {
                    errorMessages.add(msg);
                  }
                }
              }
            });
          } else if (error != null && error is String) {
            errorMessages.add(error);
          } else {
            errorMessages.add("Terjadi kesalahan yang tidak diketahui.");
          }

          emit(ErrorState(errorMessage: errorMessages));
        },
        (data) {
          emit(LoadingState(isLoading: false));
          emit(SuccessState(message: data));
        },
      );
    });
  }
}
