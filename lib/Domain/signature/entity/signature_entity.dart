class SignatureEntity {
  int? id;
  String? picture;
  String? namaPenandatangan;
  String? jabatanPenandatangan;
  String? tanggalDibuat;
  DateTime? createdAt;
  DateTime? updatedAt;

  SignatureEntity({
    this.id,
    this.picture,
    this.namaPenandatangan,
    this.jabatanPenandatangan,
    this.tanggalDibuat,
    this.createdAt,
    this.updatedAt,
  });
}
