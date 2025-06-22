class UpdateLoaParams {
  final String paperId;
  final String paperTitle;
  final List<String> paperAuthors;
  final String themeConference;
  final String status;
  final String tempatTanggal;
  final int signatureId;
  UpdateLoaParams({
    required this.paperId,
    required this.paperTitle,
    required this.themeConference,
    required this.paperAuthors,
    required this.status,
    required this.tempatTanggal,
    required this.signatureId,
  });

  UpdateLoaParams copyWith({
    String? paperId,
    String? paperTitle,
    String? themeConference,
    List<String>? paperAuthors,
    String? status,
    String? tempatTanggal,
    int? signatureId,
  }) {
    return UpdateLoaParams(
      paperId: paperId ?? this.paperId,
      paperTitle: paperTitle ?? this.paperTitle,
      paperAuthors: paperAuthors ?? this.paperAuthors,
      status: status ?? this.status,
      tempatTanggal: tempatTanggal ?? this.tempatTanggal,
      signatureId: signatureId ?? this.signatureId,
      themeConference: themeConference ?? this.themeConference,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'paper_id': paperId,
      'paper_title': paperTitle,
      'author_names': paperAuthors,
      "theme_conference": themeConference,
      'status': status,
      'tempat_tanggal': tempatTanggal,
      'place_date_conference': tempatTanggal,
      'signature_id': signatureId,
    };
  }
}
