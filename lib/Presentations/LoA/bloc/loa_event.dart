part of 'loa_bloc.dart';

sealed class LoaEvent extends Equatable {
  const LoaEvent();
}

final class GetAllLoaEvent extends LoaEvent {
  const GetAllLoaEvent();

  @override
  List<Object?> get props => [];
}

final class GetAllIcodsaLoaEvent extends LoaEvent {
  const GetAllIcodsaLoaEvent();

  @override
  List<Object?> get props => [];
}

final class UpdateLoaEvent extends LoaEvent {
  final UpdateLoaParams params;

  const UpdateLoaEvent(this.params);

  @override
  List<Object?> get props => [params];
}

final class CreateLoaEvent extends LoaEvent {
  final String paperId;
  final String paperTitle;
  final List<String> paperAuthors;
  final String status;
  final String tempatTanggal;
  final int signatureId;

  const CreateLoaEvent(
    this.paperId,
    this.paperTitle,
    this.paperAuthors,
    this.status,
    this.tempatTanggal,
    this.signatureId,
  );

  @override
  List<Object?> get props => [
        this.paperId,
        this.paperTitle,
        this.paperAuthors,
        this.status,
        this.tempatTanggal,
        this.signatureId,
      ];
}

final class CreateLoaIcodsa extends LoaEvent {
  final String paperId;
  final String paperTitle;
  final List<String> paperAuthors;
  final String status;
  final String tempatTanggal;
  final int signatureId;

  const CreateLoaIcodsa(
    this.paperId,
    this.paperTitle,
    this.paperAuthors,
    this.status,
    this.tempatTanggal,
    this.signatureId,
  );

  @override
  List<Object?> get props => [
        this.paperId,
        this.paperTitle,
        this.paperAuthors,
        this.status,
        this.tempatTanggal,
        this.signatureId,
      ];
}

final class GetSignatureId extends LoaEvent {
  @override
  List<Object?> get props => [];
}
