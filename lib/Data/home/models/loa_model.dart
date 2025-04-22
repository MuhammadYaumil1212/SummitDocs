class LOAModel {
  int? paperId;
  String? paperTitle;
  String? authorNames;
  String? status;
  String? tempatTanggal;
  int? signatureId;
  String? createdBy;
  String? createdAt;
  String? updatedAt;

  LOAModel(
      {this.paperId,
      this.paperTitle,
      this.authorNames,
      this.status,
      this.tempatTanggal,
      this.signatureId,
      this.createdBy,
      this.createdAt,
      this.updatedAt});

  LOAModel.fromJson(Map<String, dynamic> json) {
    paperId = json['paper_id'];
    paperTitle = json['paper_title'];
    authorNames = json['author_names'];
    status = json['status'];
    tempatTanggal = json['tempat_tanggal'];
    signatureId = json['signature_id'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paper_id'] = this.paperId;
    data['paper_title'] = this.paperTitle;
    data['author_names'] = this.authorNames;
    data['status'] = this.status;
    data['tempat_tanggal'] = this.tempatTanggal;
    data['signature_id'] = this.signatureId;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
