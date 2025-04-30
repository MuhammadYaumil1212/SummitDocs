part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();
}

final class CreateSignatureEvent extends SettingsEvent {
  final String signatureName;
  final String signaturePosition;
  final String createdDate;
  final File signatureFile;

  const CreateSignatureEvent({
    required this.signatureName,
    required this.signaturePosition,
    required this.signatureFile,
    required this.createdDate,
  });

  @override
  List<Object?> get props => [
        signatureName,
        signaturePosition,
        createdDate,
        signatureFile,
      ];
}
