import 'dart:io';

import 'package:SummitDocs/Domain/signature/entity/signature_entity.dart';
import 'package:SummitDocs/Domain/signature/usecase/get_all_signature_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../Data/settings/models/signature_params.dart';
import '../../../Domain/settings/usecases/create_signature_usecase.dart';
import '../../../Domain/signature/usecase/delete_signature_usecase.dart';
import '../../../core/helper/formatter/date_formatter.dart';
import '../../../service_locator.dart';

part 'signature_event.dart';
part 'signature_state.dart';

class SignatureBloc extends Bloc<SignatureEvent, SignatureState> {
  SignatureBloc() : super(SignatureInitial()) {
    on<SignatureEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ShowSignatureEvent>((event, emit) async {
      emit(LoadingSignatureState(isLoading: true));
      final result = await sl<GetAllSignatureUsecase>().call();
      result.fold(
        (error) {
          emit(LoadingSignatureState(isLoading: false));
          emit(FailedSignatureState(message: error));
        },
        (data) {
          emit(LoadingSignatureState(isLoading: false));
          emit(SuccessSignatureState(signatureList: data));
        },
      );
    });

    on<SignatureDeleteEvent>((event, emit) async {
      emit(LoadingSignatureState(isLoading: true));
      final result = await sl<DeleteSignatureUsecase>().call(
        params: event.signatureId,
      );
      result.fold(
        (error) {
          emit(LoadingSignatureState(isLoading: false));
          emit(FailedDeleteSignature(message: error));
        },
        (data) {
          emit(LoadingSignatureState(isLoading: false));
          emit(SuccessDeleteSignature(message: data));
        },
      );
    });

    on<SignatureAddEvent>((event, emit) async {
      emit(LoadingSignatureState(isLoading: true));
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
          emit(LoadingSignatureState(isLoading: false));
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

          emit(FailedSignatureState(message: errorMessages));
        },
        (data) {
          emit(LoadingSignatureState(isLoading: false));
          emit(SuccessSubmitSignature(message: data));
        },
      );
    });
  }
}
