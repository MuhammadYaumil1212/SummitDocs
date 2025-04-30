import 'dart:io';

class SignatureParams {
  final String signatureName;
  final String signaturePosition;
  final String createdDate;
  final File signatureFile;

  SignatureParams({
    required this.signatureName,
    required this.signaturePosition,
    required this.createdDate,
    required this.signatureFile,
  });

  SignatureParams copyWith({
    String? signatureName,
    String? signaturePosition,
    String? createdDate,
    File? signatureFile,
  }) {
    return SignatureParams(
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
