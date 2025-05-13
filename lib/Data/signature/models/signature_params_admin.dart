import 'dart:io';

class SignatureParamsAdmin {
  final int? id;
  final String signatureName;
  final String signaturePosition;
  final String createdDate;
  final File signatureFile;

  SignatureParamsAdmin({
    this.id,
    required this.signatureName,
    required this.signaturePosition,
    required this.createdDate,
    required this.signatureFile,
  });

  SignatureParamsAdmin copyWith({
    int? id,
    String? signatureName,
    String? signaturePosition,
    String? createdDate,
    File? signatureFile,
  }) {
    return SignatureParamsAdmin(
        id: id ?? this.id,
        signatureName: signatureName ?? this.signatureName,
        signaturePosition: signaturePosition ?? this.signaturePosition,
        createdDate: createdDate ?? this.createdDate,
        signatureFile: signatureFile ?? this.signatureFile);
  }

  Map<String, dynamic> toMap() {
    return {
      'nama_penandatangan': signatureName,
      'jabatan_penandatangan': signaturePosition,
      'tanggal_dibuat': createdDate,
      'picture': signatureFile,
    };
  }
}
