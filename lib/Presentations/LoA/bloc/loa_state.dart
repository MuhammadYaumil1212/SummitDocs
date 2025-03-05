part of 'loa_bloc.dart';

sealed class LoaState extends Equatable {
  const LoaState();
}

final class LoaInitial extends LoaState {
  @override
  List<Object> get props => [];
}
