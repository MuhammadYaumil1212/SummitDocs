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

final class ResetPasswordEvent extends SettingsEvent {
  final int id;
  final String name;
  final String username;
  final String email;
  final String password;

  ResetPasswordEvent({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [id, name, username, email, password];
}
