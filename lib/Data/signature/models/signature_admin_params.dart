import 'dart:io';

class SignatureAdminParams {
  final String signatureName;
  final String signaturePosition;
  final String createdDate;
  final File signatureFile;

  SignatureAdminParams({
    required this.signatureName,
    required this.signaturePosition,
    required this.createdDate,
    required this.signatureFile,
  });

  SignatureAdminParams copyWith({
    String? signatureName,
    String? signaturePosition,
    String? createdDate,
    File? signatureFile,
  }) {
    return SignatureAdminParams(
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
