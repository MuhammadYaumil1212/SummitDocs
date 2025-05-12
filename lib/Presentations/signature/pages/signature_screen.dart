import 'dart:io';

import 'package:SummitDocs/Domain/signature/entity/signature_entity.dart';
import 'package:SummitDocs/commons/constants/api_url.dart';
import 'package:SummitDocs/commons/widgets/app_scaffold.dart';
import 'package:SummitDocs/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../commons/constants/string.dart';
import '../../../commons/widgets/app_button.dart';
import '../../../commons/widgets/app_datatable.dart';
import '../../../commons/widgets/app_text.dart';
import '../../../commons/widgets/app_textfield.dart';
import '../../../core/helper/formatter/date_formatter.dart';
import '../../../core/helper/message/message.dart';
import '../bloc/signature_bloc.dart';

class SignatureScreen extends StatefulWidget {
  const SignatureScreen({super.key});

  @override
  State<SignatureScreen> createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  final _bloc = SignatureBloc();
  TextEditingController namaPenandatangan = TextEditingController();
  TextEditingController jabatanPenandatangan = TextEditingController();
  TextEditingController tanggalDibuat = TextEditingController();
  File? selectedSignatureFile;

  final List<SignatureEntity> signatureList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.add(ShowSignatureEvent());
  }

  void reload() {
    setState(() {
      signatureList.clear();
      _bloc.add(ShowSignatureEvent());
    });
  }

  void clearField() {
    namaPenandatangan.clear();
    jabatanPenandatangan.clear();
    tanggalDibuat.clear();
    selectedSignatureFile = null;
  }

  Future<void> _handleRefresh() async {
    setState(() {
      reload();
      clearField();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bloc: _bloc,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: SvgPicture.asset(
          AppString.logoApp,
          width: 45,
          height: 45,
        ),
        backgroundColor: AppColors.background,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(color: AppColors.grayBackground, height: 4.0),
        ),
      ),
      listener: (BuildContext context, SignatureState state) {
        if (state is SuccessSignatureState) {
          setState(() {
            signatureList.clear();
            final sortedSignature =
                List<SignatureEntity>.from(state.signatureList)
                  ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

            for (var user in sortedSignature) {
              signatureList.add(user);
            }
          });
        }

        if (state is SuccessSubmitSignature) {
          Navigator.of(context).pop();
          clearField();
          reload();
          return DisplayMessage.successMessage(state.message, context);
        }

        if (state is SuccessDeleteSignature) {
          Navigator.of(context).pop();
          clearField();
          reload();
          DisplayMessage.successMessage(state.message, context);
        }

        if (state is FailedSignatureState) {
          Navigator.of(context).pop();
          for (var item in state.message) {
            DisplayMessage.errorMessage(item, context);
          }
        }
      },
      appWidget: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: AppColors.primary,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, "Signature"),
                const SizedBox(height: 20),
                _buildTable("Peserta", signatureList),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          text: title,
          fontWeight: FontWeight.w700,
          fontSize: 30,
        ),
        FileAddButton(
          onTap: () => _showUploadSignature(context),
          color: AppColors.primary,
          text: "Tambah Data",
        )
      ],
    );
  }

  void _showUploadSignature(BuildContext context) {
    namaPenandatangan.clear();
    jabatanPenandatangan.clear();
    tanggalDibuat.clear();
    selectedSignatureFile = null;

    showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder<SignatureBloc, SignatureState>(
          bloc: _bloc,
          builder: (context, state) {
            final isLoading = state is LoadingSignatureState && state.isLoading;
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: Colors.white,
              title: const AppText(
                text: "Upload Signature",
                fontSize: 21,
                fontWeight: FontWeight.w700,
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    AppTextfield(
                      prefixIcon: Icon(Icons.person_outline),
                      hint: "Nama Penandatangan",
                      controller: namaPenandatangan,
                    ),
                    AppTextfield(
                      prefixIcon: Icon(Icons.work_outline),
                      hint: "Jabatan Penandatangan",
                      controller: jabatanPenandatangan,
                    ),
                    AppDatePicker(
                      hint: "Tanggal Dibuat",
                      readOnly: true,
                      value: (value) {
                        tanggalDibuat.text = value;
                      },
                      dateController: tanggalDibuat,
                    ),
                    AppUploadTextfield(
                      hint: "Upload Signature",
                      onFileSelected: (platformFile) {
                        setState(() {
                          selectedSignatureFile = File(platformFile.path ?? "");
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    AppButton(
                      text: "Upload",
                      isLoading: isLoading,
                      action: () {
                        if (selectedSignatureFile == null ||
                            namaPenandatangan.text.isEmpty ||
                            jabatanPenandatangan.text.isEmpty ||
                            tanggalDibuat.text.isEmpty) {
                          Navigator.of(context).pop();
                          DisplayMessage.errorMessage(
                            "Semua field wajib diisi",
                            context,
                          );
                          return;
                        }
                        _bloc.add(
                          SignatureAddEvent(
                            signatureName: namaPenandatangan.text,
                            signaturePosition: jabatanPenandatangan.text,
                            signatureFile: selectedSignatureFile!,
                            createdDate: DateFormatter.parseFromString(
                              tanggalDibuat.text,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    AppButton(
                      text: "Batalkan",
                      action: () => Navigator.of(context).pop(),
                      borderColor: AppColors.grayBackground2,
                      backgroundColor: AppColors.secondaryBackground,
                      fontColor: Colors.red,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTable(String title, List<dynamic> dataList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: title,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 5),
        dataList.isNotEmpty
            ? AppDataTable(
                columns: _buildColumns(),
                data: signatureList,
                rowBuilder: _buildRow,
              )
            : Center(
                child: AppText(text: "Please wait......"),
              ),
      ],
    );
  }

  List<DataColumn> _buildColumns() {
    return [
      _centeredColumn("Lihat Tanda Tangan"),
      _centeredColumn("Nama Penandatangan"),
      _centeredColumn("Jabatan Penandatangan"),
      _centeredColumn("Tanggal Dibuat"),
      _centeredColumn("Tindakan"),
    ];
  }

  DataColumn _centeredColumn(String title) {
    return DataColumn(
      label: Center(child: AppText(text: title)),
    );
  }

  DataRow _buildRow(SignatureEntity signature) {
    return DataRow(
      cells: [
        DataCell(GestureDetector(
          onTap: () => _showImageSignature(signature),
          child: AppText(text: "Lihat Gambar", fontColor: AppColors.primary),
        )),
        DataCell(AppText(text: signature.namaPenandatangan ?? "-")),
        DataCell(AppText(text: signature.jabatanPenandatangan ?? "-")),
        DataCell(AppText(text: signature.tanggalDibuat ?? "-")),
        DataCell(
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionButton(icon: AppString.editIcon, action: () {}),
                const SizedBox(width: 10),
                ActionButton(
                  icon: AppString.trashIcon,
                  action: () => _showDialogDelete(signature.id ?? -1),
                  backgroundColor: AppColors.redFailed,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showDialogDelete(int id) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder<SignatureBloc, SignatureState>(
          bloc: _bloc,
          builder: (context, state) {
            var isLoading = state is LoadingSignatureState && state.isLoading;
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: Colors.white,
              title: const AppText(
                text: "Hapus",
                fontSize: 21,
                fontWeight: FontWeight.w700,
              ),
              content: const AppText(
                text: "Apakah anda yakin ingin menghapus?",
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              actions: [
                AppButton(
                  text: "Hapus",
                  backgroundColor: AppColors.redFailed,
                  fontColor: AppColors.background,
                  isLoading: isLoading,
                  action: () async {
                    _bloc.add(SignatureDeleteEvent(signatureId: id));
                  },
                ),
                AppButton(
                  text: "Batalkan",
                  borderColor: AppColors.grayBackground2,
                  action: () => Navigator.of(context).pop(),
                  backgroundColor: AppColors.background,
                  fontColor: AppColors.redFailed,
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showImageSignature(SignatureEntity detail) {
    showDialog(
      context: context,
      builder: (context) {
        print("data gambar: ${ApiUrl.baseUrl}${detail.picture}");
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white,
          title: AppText(
            text: "Tanda Tangan",
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Image.network(
                  detail.picture != null
                      ? "${ApiUrl.baseUrl}${detail.picture}"
                      : "",
                  fit: BoxFit.fitHeight,
                  width: 50,
                  height: 50,
                  errorBuilder: (context, error, stackTrace) {
                    return AppText(text: "Gambar tidak ditemukan");
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    action: () {
                      Navigator.of(context).pop();
                    },
                    text: "Tutup",
                    borderColor: AppColors.grayBackground2,
                    backgroundColor: AppColors.secondaryBackground,
                    fontColor: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
