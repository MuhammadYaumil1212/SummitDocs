import 'package:SummitDocs/Presentations/manage_account/bloc/manage_account_bloc.dart';
import 'package:SummitDocs/commons/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Domain/manage_account/entity/user_entity.dart';
import '../../../commons/constants/string.dart';
import '../../../commons/widgets/app_button.dart';
import '../../../commons/widgets/app_datatable.dart';
import '../../../commons/widgets/app_text.dart';
import '../../../commons/widgets/app_textfield.dart';
import '../../../core/config/theme/app_colors.dart';
import '../../../core/helper/message/message.dart';

class ManageAccount extends StatefulWidget {
  const ManageAccount({super.key});

  @override
  State<ManageAccount> createState() => _ManageAccountState();
}

class _ManageAccountState extends State<ManageAccount> {
  final ManageAccountBloc _bloc = ManageAccountBloc();
  final List<UserEntity> accountPeserta = [];
  final List<UserEntity> accountSuperAdmin = [];

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController role = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.add(LoadManageAccount());
  }

  void reloadAll() {
    accountPeserta.clear();
    accountSuperAdmin.clear();
    _bloc.add(LoadManageAccount());
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    reloadAll();
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
          child: Container(
            color: AppColors.grayBackground,
            height: 4.0,
          ),
        ),
      ),
      listener: (BuildContext context, ManageAccountState state) {
        if (state is TableLoaded) {
          setState(() {
            accountPeserta.clear();
            accountSuperAdmin.clear();
            for (var user in state.userList) {
              if (user.roleId == 1) {
                accountSuperAdmin.add(user);
              } else if (user.roleId == 2 || user.roleId == 3) {
                accountPeserta.add(user);
              }
            }
          });
        }
        if (state is FailedTable) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
        if (state is FailedSubmit) {
          state.errorMessage.map((item) {
            return DisplayMessage.errorMessage(item, context);
          }).toList();
        }

        if (state is SuccessSubmit) {
          return DisplayMessage.successMessage(state.successMessage, context);
        }
      },
      appWidget: BlocBuilder<ManageAccountBloc, ManageAccountState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: _handleRefresh,
            color: AppColors.primary,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildHeader(context, "Kelola Akun"),
                const SizedBox(height: 20),
                _buildTablePeserta("Peserta", accountPeserta),
                _buildTablePeserta("Pengurus", accountSuperAdmin),
              ],
            ),
          );
        },
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
          onTap: () => _showAddDataDialog(context),
          color: AppColors.primary,
          text: "Tambah Akun",
        )
      ],
    );
  }

  Widget _buildTablePeserta(String title, List<UserEntity> dataList) {
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
                columns: _buildColumnsPeserta(),
                data: dataList,
                rowBuilder: _buildRowPeserta,
              )
            : Center(child: AppText(text: "Please Wait.....")),
      ],
    );
  }

  List<DataColumn> _buildColumnsPeserta() {
    return [
      _centeredColumn("Id"),
      _centeredColumn("Username"),
      _centeredColumn("Email"),
      _centeredColumn("Tindakan"),
    ];
  }

  DataColumn _centeredColumn(String title) {
    return DataColumn(
      label: Center(
        child: AppText(text: title),
      ),
    );
  }

  DataRow _buildRowPeserta(UserEntity conference) {
    return DataRow(
      cells: [
        DataCell(AppText(text: conference.id.toString())),
        DataCell(AppText(text: conference.username ?? "")),
        DataCell(AppText(text: conference.email ?? "")),
        DataCell(
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionButton(
                  icon: AppString.trashIcon,
                  backgroundColor: AppColors.redFailed,
                  action: () => _showDeleteVirtualDialog(0),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showAddDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder<ManageAccountBloc, ManageAccountState>(
          bloc: _bloc,
          builder: (context, state) {
            final isLoading = state is LoadingSubmit && state.isLoading;
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.white,
              title: AppText(
                text: "Tambah Data",
                fontSize: 21,
                fontWeight: FontWeight.w700,
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppTextfield(
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: AppColors.grayBackground3,
                      ),
                      hint: "Username",
                      controller: username,
                    ),
                    AppTextfield(
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: AppColors.grayBackground3,
                      ),
                      hint: "Email",
                      controller: email,
                    ),
                    AppTextfield(
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: AppColors.grayBackground3,
                      ),
                      obscureText: true,
                      hint: "Kata Sandi Baru",
                      controller: password,
                    ),
                    AppDropdown(
                      label: "Roles",
                      items: ["Admin ICODSA", "Admin ICICYTA"],
                      onChanged: (value) {
                        role.text = value ?? "";
                      },
                    ),
                    const SizedBox(height: 10),
                    AppText(text: "Biodata", fontSize: 15),
                    const SizedBox(height: 10),
                    AppTextfield(
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: AppColors.grayBackground3,
                      ),
                      hint: "Nama Lengkap",
                      controller: fullname,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: AppButton(
                          text: "Masukkan",
                          isLoading: isLoading,
                          action: () {
                            _bloc.add(
                              CreateAccount(
                                name: fullname.text,
                                username: username.text,
                                email: email.text,
                                password: password.text,
                                role: role.text,
                              ),
                            );
                            Future.delayed(Duration(seconds: 2), () {
                              Navigator.of(context).pop();
                              reloadAll();
                            });
                          }),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: AppButton(
                        action: () {
                          Navigator.of(context).pop();
                        },
                        text: "Batalkan",
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
      },
    );
  }

  void _showDeleteVirtualDialog(int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white,
          title: AppText(
            text: "Hapus Data",
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  text: "Apakah anda yakin ingin menghapus ?",
                  textAlign: TextAlign.center,
                  fontSize: 20,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: AppButton(
                      text: "Hapus Data",
                      backgroundColor: AppColors.redFailed,
                      action: () {
                        Navigator.of(context).pop();
                      }),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: AppButton(
                    action: () {
                      Navigator.of(context).pop();
                    },
                    text: "Batalkan",
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
