import 'package:SummitDocs/Presentations/invoice/bloc/invoice_bloc.dart';
import 'package:SummitDocs/Presentations/invoice/pages/invoice_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../commons/constants/string.dart';
import '../../../commons/widgets/app_button.dart';
import '../../../commons/widgets/app_datatable.dart';
import '../../../commons/widgets/app_scaffold.dart';
import '../../../commons/widgets/app_text.dart';
import '../../../commons/widgets/app_textfield.dart';
import '../../../core/config/theme/app_colors.dart';

class FilesInvoiceScreen extends StatefulWidget {
  final int roleId;
  final String title;
  const FilesInvoiceScreen(
      {super.key, required this.roleId, required this.title});

  @override
  State<FilesInvoiceScreen> createState() => _FilesInvoiceScreenState();
}

class _FilesInvoiceScreenState extends State<FilesInvoiceScreen> {
  final InvoiceBloc _bloc = InvoiceBloc();
  TextEditingController virtualAccountNumber = TextEditingController();
  TextEditingController holderName = TextEditingController();
  TextEditingController nameBank = TextEditingController();
  TextEditingController nameBranch = TextEditingController();
  TextEditingController nameBankTransfer = TextEditingController();
  TextEditingController swiftCode = TextEditingController();
  TextEditingController beneficiaryName = TextEditingController();
  TextEditingController beneficiaryBankAcc = TextEditingController();
  TextEditingController nameBranchTransfer = TextEditingController();
  TextEditingController nameBranchAddressTransfer = TextEditingController();
  TextEditingController cityName = TextEditingController();
  TextEditingController countryName = TextEditingController();
  final List<InvoiceEntity> conferences = List.generate(
    15,
    (index) => InvoiceEntity(
      index + 1,
      "title",
      "ConferenceTitle",
      "John Doe",
      "10:00",
      "Bandung, Coblong",
      "Accepted",
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bloc: _bloc,
      listener: (context, state) {},
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
      appWidget: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, widget.title),
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
          text: "Invoice \n${title}",
          fontWeight: FontWeight.w700,
          fontSize: 30,
        ),
        FileAddButton(
          onTap: () => _showAddDataDialog(context),
          color: AppColors.primary,
          text: "Tambah Data",
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
      _centeredColumn("Paper ID"),
      _centeredColumn("Judul Paper"),
      _centeredColumn("Judul Conference"),
      _centeredColumn("Penulis"),
      _centeredColumn("Waktu"),
      _centeredColumn("Tanggal dan Tempat"),
      _centeredColumn("Status"),
      _centeredColumn("Tindakan"),
    ];
  }

  DataColumn _centeredColumn(String title) {
    return DataColumn(
      label: Center(child: AppText(text: title)),
    );
  }

  DataRow _buildRow(InvoiceEntity conference) {
    return DataRow(
      cells: [
        DataCell(Center(child: AppText(text: conference.paperId.toString()))),
        DataCell(Center(child: AppText(text: conference.paperTitle))),
        DataCell(Center(child: AppText(text: conference.conferenceTitle))),
        DataCell(Center(child: AppText(text: conference.writer))),
        DataCell(Center(child: AppText(text: conference.time))),
        DataCell(Center(child: AppText(text: conference.dateAndPlace))),
        DataCell(Center(child: AppText(text: conference.status))),
        DataCell(
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionButton(icon: AppString.infoIcon, action: () {}),
                const SizedBox(width: 10),
                ActionButton(icon: AppString.downloadIcon, action: () {}),
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
                AppText(
                  text: "Virtual Account",
                  fontSize: 14,
                ),
                const SizedBox(height: 10),
                AppTextfield(
                  prefixIcon: Icon(
                    Icons.pin_outlined,
                    color: AppColors.grayBackground3,
                  ),
                  hint: "No. Virtual Account",
                  controller: virtualAccountNumber,
                ),
                AppTextfield(
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: AppColors.grayBackground3,
                  ),
                  hint: "Account Holder Name",
                  controller: holderName,
                ),
                AppTextfield(
                  prefixIcon: Icon(
                    Icons.title,
                    color: AppColors.grayBackground3,
                  ),
                  hint: "Bank Name",
                  controller: nameBank,
                ),
                AppTextfield(
                  prefixIcon: Icon(
                    Icons.title,
                    color: AppColors.grayBackground3,
                  ),
                  hint: "Bank Branch",
                  controller: nameBranch,
                ),
                const SizedBox(height: 10),
                AppText(
                  text: "Bank Transfer",
                  fontSize: 14,
                ),
                const SizedBox(height: 10),
                AppTextfield(
                  prefixIcon: Icon(
                    Icons.title,
                    color: AppColors.grayBackground3,
                  ),
                  hint: "Bank Name",
                  controller: nameBankTransfer,
                ),
                AppTextfield(
                  prefixIcon: Icon(
                    Icons.pin_outlined,
                    color: AppColors.grayBackground3,
                  ),
                  hint: "Swift Code",
                  controller: swiftCode,
                ),
                AppTextfield(
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: AppColors.grayBackground3,
                  ),
                  hint: "Beneficiary Name",
                  controller: beneficiaryName,
                ),
                AppTextfield(
                  prefixIcon: Icon(
                    Icons.pin_outlined,
                    color: AppColors.grayBackground3,
                  ),
                  hint: "Beneficiary Bank Account",
                  controller: beneficiaryBankAcc,
                ),
                AppTextfield(
                  prefixIcon: Icon(
                    Icons.title,
                    color: AppColors.grayBackground3,
                  ),
                  hint: "Bank Branch",
                  controller: nameBranchTransfer,
                ),
                AppTextfield(
                  prefixIcon: Icon(
                    Icons.title,
                    color: AppColors.grayBackground3,
                  ),
                  hint: "Bank Address",
                  controller: nameBranchAddressTransfer,
                ),
                AppTextfield(
                  hint: "City",
                  controller: cityName,
                ),
                AppTextfield(
                  hint: "Country",
                  controller: countryName,
                ),
                const SizedBox(height: 10),
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
