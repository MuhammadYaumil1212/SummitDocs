import 'package:SummitDocs/Presentations/manage_account/bloc/manage_account_bloc.dart';
import 'package:SummitDocs/Presentations/manage_account/pages/user_entity.dart';
import 'package:SummitDocs/commons/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../commons/constants/string.dart';
import '../../../commons/widgets/app_button.dart';
import '../../../commons/widgets/app_datatable.dart';
import '../../../commons/widgets/app_text.dart';
import '../../../commons/widgets/app_textfield.dart';
import '../../../core/config/theme/app_colors.dart';
import '../../invoice/pages/invoice_entity.dart';

class ManageAccount extends StatefulWidget {
  const ManageAccount({super.key});

  @override
  State<ManageAccount> createState() => _ManageAccountState();
}

class _ManageAccountState extends State<ManageAccount> {
  final ManageAccountBloc _bloc = ManageAccountBloc();
  //virtual acc
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final List<UserEntity> conferences = List.generate(
    15,
    (index) => UserEntity(
        id: index + 1, email: "email@gmail.com", username: "username"),
  );

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bloc: ManageAccountBloc(),
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
      listener: (BuildContext context, ManageAccountState state) {},
      appWidget: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, "Kelola Akun"),
              const SizedBox(height: 20),
              _buildTable("Peserta"),
              _buildTable("Pengurus"),
            ],
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
          onTap: () => _showAddDataDialog(context),
          color: AppColors.primary,
          text: "Tambah Akun",
        )
      ],
    );
  }

  Widget _buildTable(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: title,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 5),
        AppDataTable(
          columns: _buildColumns(),
          data: conferences,
          rowBuilder: _buildRow,
        ),
      ],
    );
  }

  List<DataColumn> _buildColumns() {
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

  DataRow _buildRow(UserEntity conference) {
    return DataRow(
      cells: [
        DataCell(Center(child: AppText(text: conference.id.toString()))),
        DataCell(Center(child: AppText(text: conference.username))),
        DataCell(Center(child: AppText(text: conference.email))),
        DataCell(
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionButton(
                  icon: AppString.trashIcon,
                  backgroundColor: AppColors.redFailed,
                  action: () {},
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
                    print("Selected: $value");
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: AppButton(text: "Masukkan", action: () {}),
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
