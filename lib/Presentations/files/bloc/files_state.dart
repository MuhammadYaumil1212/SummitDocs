part of 'files_bloc.dart';

sealed class FilesState extends Equatable {
  const FilesState();
}

final class FilesInitial extends FilesState {
  @override
  List<Object> get props => [];
}
