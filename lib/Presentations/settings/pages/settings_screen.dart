import 'dart:io';

import 'package:SummitDocs/Presentations/signin/pages/signin_screen.dart';
import 'package:SummitDocs/commons/widgets/app_button.dart';
import 'package:SummitDocs/core/config/theme/app_colors.dart';
import 'package:SummitDocs/core/helper/formatter/date_formatter.dart';
import 'package:SummitDocs/core/helper/message/message.dart';
import 'package:SummitDocs/core/helper/navigation/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../commons/constants/string.dart';
import '../../../commons/widgets/app_text.dart';
import '../../../commons/widgets/app_textfield.dart';
import '../../../core/helper/storage/AppStorage.dart';
import '../bloc/settings_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AppStorage? storage;
  final _bloc = SettingsBloc();

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController namaPenandatangan = TextEditingController();
  TextEditingController jabatanPenandatangan = TextEditingController();
  TextEditingController tanggalDibuat = TextEditingController();

  File? selectedSignatureFile;

  @override
  void initState() {
    super.initState();
    initStorage();
  }

  void initStorage() async {
    final instance = await AppStorage.instance;
    setState(() {
      storage = instance;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (storage == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return BlocBuilder<SettingsBloc, SettingsState>(
      bloc: _bloc,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: "Pengaturan",
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 20),
                _buildProfileCard(),
                const SizedBox(height: 20),
                AppButton(
                  text: "Logout",
                  action: () => _showDialogLogout(),
                  backgroundColor: Colors.white,
                  iconColor: Colors.redAccent,
                  borderColor: AppColors.grayBackground2,
                  icon: Icons.logout,
                  fontColor: AppColors.redFailed,
                  fontWeight: FontWeight.w400,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDialogLogout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.white,
          title: const AppText(
            text: "Logout",
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
          content: const AppText(
            text: "Apakah anda yakin ingin keluar?",
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          actions: [
            AppButton(
              text: "Keluar",
              backgroundColor: AppColors.redFailed,
              fontColor: AppColors.background,
              action: () async {
                await storage?.delete(AppString.TOKEN_KEY);
                await storage?.delete(AppString.ROLE);
                await storage?.delete(AppString.USERNAME);
                await storage?.delete(AppString.EMAIL);
                AppNavigator.pushAndRemove(context, SigninScreen());
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
  }

  Widget _buildProfileCard() {
    final getRole = storage?.get<int>(AppString.ROLE);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(
            text: "Profil Akun",
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
          const SizedBox(height: 10),
          _buildInfoRow("Username", storage?.get(AppString.USERNAME) ?? "-"),
          _buildInfoRow("Email", storage?.get(AppString.EMAIL) ?? "-"),
          _buildInfoRow(
            "Role",
            getRole == 1
                ? "SuperAdmin"
                : getRole == 2
                    ? "ICODSA"
                    : "ICICYTA",
          ),
          const SizedBox(height: 20),
          AppButton(
            action: () => _showUploadSignature(context),
            text: "Upload file signature",
            borderColor: AppColors.grayBackground2,
            backgroundColor: AppColors.secondaryBackground,
            fontColor: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(height: 10),
          AppButton(
            action: () => _showChangePasswordDialog(context),
            text: "Ganti Password",
            borderColor: AppColors.grayBackground2,
            backgroundColor: AppColors.secondaryBackground,
            fontColor: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          AppText(text: "$label :", fontWeight: FontWeight.w500),
          const SizedBox(width: 8),
          Expanded(child: AppText(text: value)),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    oldPasswordController.clear();
    newPasswordController.clear();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.white,
          title: const AppText(
            text: "Ganti Password",
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextfield(
                  prefixIcon: Icon(Icons.lock_outline,
                      color: AppColors.grayBackground3),
                  obscureText: true,
                  hint: "Kata sandi lama",
                  controller: oldPasswordController,
                ),
                AppTextfield(
                  prefixIcon: Icon(Icons.lock_outline,
                      color: AppColors.grayBackground3),
                  obscureText: true,
                  hint: "Kata sandi baru",
                  controller: newPasswordController,
                ),
                const SizedBox(height: 10),
                AppButton(
                  text: "Masukkan",
                  action: () {
                    // Tambahkan logika update password di sini
                    Navigator.of(context).pop();
                  },
                ),
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
  }

  void _showUploadSignature(BuildContext context) {
    namaPenandatangan.clear();
    jabatanPenandatangan.clear();
    tanggalDibuat.clear();
    selectedSignatureFile = null;

    showDialog(
      context: context,
      builder: (context) {
        return BlocListener<SettingsBloc, SettingsState>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is SuccessState) {
              Navigator.of(context).pop();
              DisplayMessage.successMessage(state.message, context);
            } else if (state is ErrorState) {
              Navigator.of(context).pop();
              for (var item in state.errorMessage) {
                DisplayMessage.errorMessage(item, context);
              }
            }
          },
          child: AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                  BlocBuilder<SettingsBloc, SettingsState>(
                    bloc: _bloc,
                    builder: (context, state) {
                      final isLoading =
                          state is LoadingState && state.isLoading;
                      return AppButton(
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
                            CreateSignatureEvent(
                              signatureName: namaPenandatangan.text,
                              signaturePosition: jabatanPenandatangan.text,
                              signatureFile: selectedSignatureFile!,
                              createdDate: DateFormatter.parseFromString(
                                tanggalDibuat.text,
                              ),
                            ),
                          );
                        },
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
          ),
        );
      },
    );
  }
}
