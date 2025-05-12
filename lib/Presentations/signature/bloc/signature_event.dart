part of 'signature_bloc.dart';

sealed class SignatureEvent extends Equatable {
  const SignatureEvent();
}

final class SignatureAddEvent extends SignatureEvent {
  final String signatureName;
  final String signaturePosition;
  final String createdDate;
  final File signatureFile;

  const SignatureAddEvent({
    required this.signatureName,
    required this.signaturePosition,
    required this.signatureFile,
    required this.createdDate,
  });

  @override
  List<Object?> get props =>
      [signatureName, signaturePosition, createdDate, signatureFile];
}

final class SignatureUpdateEvent extends SignatureEvent {
  final String signatureName;
  final String signaturePosition;
  final String createdDate;
  final File signatureFile;

  const SignatureUpdateEvent({
    required this.signatureName,
    required this.signaturePosition,
    required this.signatureFile,
    required this.createdDate,
  });

  @override
  List<Object?> get props =>
      [signatureName, signaturePosition, createdDate, signatureFile];
}

final class ShowSignatureEvent extends SignatureEvent {
  ShowSignatureEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class SignatureDeleteEvent extends SignatureEvent {
  final int signatureId;

  const SignatureDeleteEvent({required this.signatureId});

  @override
  List<Object?> get props => [signatureId];
}
