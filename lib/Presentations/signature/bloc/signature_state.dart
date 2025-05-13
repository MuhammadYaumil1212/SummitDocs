part of 'signature_bloc.dart';

sealed class SignatureState extends Equatable {
  const SignatureState();
}

final class SignatureInitial extends SignatureState {
  @override
  List<Object> get props => [];
}

//show data
final class LoadingSignatureState extends SignatureState {
  final bool isLoading;
  const LoadingSignatureState({this.isLoading = false});
  @override
  List<Object> get props => [isLoading];
}

final class FailedSignatureState extends SignatureState {
  final List<String> message;
  const FailedSignatureState({required this.message});
  @override
  List<Object> get props => [message];
}

final class SuccessSignatureState extends SignatureState {
  final List<SignatureEntity> signatureList;
  const SuccessSignatureState({required this.signatureList});
  @override
  List<Object> get props => [signatureList];
}

//submit
final class SuccessSubmitSignature extends SignatureState {
  final String message;
  const SuccessSubmitSignature({required this.message});
  @override
  List<Object> get props => [message];
}

//delete
final class SuccessDeleteSignature extends SignatureState {
  final String message;
  const SuccessDeleteSignature({required this.message});
  @override
  List<Object> get props => [message];
}

final class FailedDeleteSignature extends SignatureState {
  final String message;
  const FailedDeleteSignature({required this.message});
  @override
  List<Object> get props => [message];
}

//update
final class SuccessUpdateSignature extends SignatureState {
  final String message;
  const SuccessUpdateSignature({required this.message});
  @override
  List<Object> get props => [message];
}

final class FailedUpdateSignature extends SignatureState {
  final List<String> message;
  const FailedUpdateSignature({required this.message});
  @override
  List<Object> get props => [message];
}
