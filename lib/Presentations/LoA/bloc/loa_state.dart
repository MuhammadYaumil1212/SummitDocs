part of 'loa_bloc.dart';

sealed class LoaState extends Equatable {
  const LoaState();
}

final class LoaInitial extends LoaState {
  @override
  List<Object> get props => [];
}

final class LoadingState extends LoaState {
  final bool isLoading;
  LoadingState({required this.isLoading});
  @override
  List<Object> get props => [isLoading];
}

final class SuccessState extends LoaState {
  final List<LoaEntity> data;

  const SuccessState(this.data);

  @override
  List<Object> get props => [data];
}

final class SuccessSignatureState extends LoaState {
  final List<SignatureEntity> data;

  const SuccessSignatureState(this.data);

  @override
  List<Object> get props => [data];
}

final class FailedState extends LoaState {
  final List<String> message;

  const FailedState(this.message);

  @override
  List<Object> get props => [message];
}

final class SuccessLoaCreate extends LoaState {
  final String message;

  const SuccessLoaCreate(this.message);

  @override
  List<Object> get props => [message];
}

final class LoadingSignatureId extends LoaState {
  final bool isLoading;

  const LoadingSignatureId({required this.isLoading});

  @override
  List<Object> get props => [isLoading];
}
