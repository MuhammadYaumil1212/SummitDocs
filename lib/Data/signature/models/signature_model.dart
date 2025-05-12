class SignatureModel {
  int? id;
  String? picture;
  String? namaPenandatangan;
  String? jabatanPenandatangan;
  String? tanggalDibuat;
  String? createdAt;
  String? updatedAt;

  SignatureModel(
      {this.id,
      this.picture,
      this.namaPenandatangan,
      this.jabatanPenandatangan,
      this.tanggalDibuat,
      this.createdAt,
      this.updatedAt});

  SignatureModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    picture = json['picture'];
    namaPenandatangan = json['nama_penandatangan'];
    jabatanPenandatangan = json['jabatan_penandatangan'];
    tanggalDibuat = json['tanggal_dibuat'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['picture'] = this.picture;
    data['nama_penandatangan'] = this.namaPenandatangan;
    data['jabatan_penandatangan'] = this.jabatanPenandatangan;
    data['tanggal_dibuat'] = this.tanggalDibuat;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
