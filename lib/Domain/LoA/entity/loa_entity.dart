class LoaEntity {
  int? id;
  String? paperId;
  String? paperTitle;
  List<String>? authorNames;
  String? status;
  String? tempatTanggal;
  int? signatureId;
  int? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  LoaEntity(
      {this.id,
      this.paperId,
      this.paperTitle,
      this.authorNames,
      this.status,
      this.tempatTanggal,
      this.signatureId,
      this.createdBy,
      this.createdAt,
      this.updatedAt});
}
