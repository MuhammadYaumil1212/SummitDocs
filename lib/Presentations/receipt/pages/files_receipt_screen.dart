import 'package:SummitDocs/Presentations/receipt/bloc/receipt_bloc.dart';
import 'package:SummitDocs/Presentations/receipt/pages/receipt_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../commons/constants/string.dart';
import '../../../commons/widgets/app_button.dart';
import '../../../commons/widgets/app_datatable.dart';
import '../../../commons/widgets/app_scaffold.dart';
import '../../../commons/widgets/app_text.dart';
import '../../../commons/widgets/app_textfield.dart';
import '../../../core/config/theme/app_colors.dart';

class FilesReceiptScreen extends StatelessWidget {
  FilesReceiptScreen({super.key});
  final ReceiptBloc _bloc = ReceiptBloc();
  final TextEditingController virtualAccountNumber = TextEditingController();
  final TextEditingController holderName = TextEditingController();
  final TextEditingController nameBank = TextEditingController();
  final TextEditingController nameBranch = TextEditingController();
  final TextEditingController paymentDate = TextEditingController();
  final TextEditingController placeAndTitle = TextEditingController();

  final List<ReceiptEntity> conferences = List.generate(
    15,
    (index) => ReceiptEntity(
      "index + 1",
      "title",
      "ConferenceTitle",
      "John Doe",
      "10:00",
      "Bandung, Coblong",
      "Accepted",
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
              _buildHeader(context, "ICODSA"),
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
          text: "Receipt \n${title}",
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
      _centeredColumn("Received From"),
      _centeredColumn("Amount"),
      _centeredColumn("In Payment of"),
      _centeredColumn("Payment Date"),
      _centeredColumn("Invoice No."),
      _centeredColumn("Conference Title"),
      _centeredColumn("User Conference Title"),
      _centeredColumn("Place and date"),
      _centeredColumn("Signature"),
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

  //
  DataRow _buildRow(ReceiptEntity conference) {
    return DataRow(
      cells: [
        DataCell(
            Center(child: AppText(text: conference.receivedFrom.toString()))),
        DataCell(Center(child: AppText(text: conference.amount))),
        DataCell(Center(child: AppText(text: conference.conferenceTitle))),
        DataCell(Center(child: AppText(text: conference.inPaymentOf))),
        DataCell(Center(child: AppText(text: conference.paymentDate))),
        DataCell(Center(child: AppText(text: conference.invoiceNo))),
        DataCell(Center(child: AppText(text: conference.conferenceTitle))),
        DataCell(Center(child: AppText(text: conference.placeAndDate))),
        DataCell(
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionButton(icon: AppString.infoIcon, action: () {}),
              ],
            ),
          ),
        ),
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
                AppTextfield(
                  prefixIcon: Icon(
                    Icons.title,
                    color: AppColors.grayBackground3,
                  ),
                  hint: "Received From",
                  controller: virtualAccountNumber,
                ),
                AppTextfield(
                  prefixIcon: Icon(
                    Icons.pin_outlined,
                    color: AppColors.grayBackground3,
                  ),
                  hint: "Amount",
                  controller: holderName,
                ),
                AppTextfield(
                  prefixIcon: Icon(
                    Icons.title,
                    color: AppColors.grayBackground3,
                  ),
                  hint: "In payment of",
                  controller: nameBank,
                ),
                AppDatePicker(
                  dateController: paymentDate,
                  hint: "Payment Date",
                  value: (String value) {},
                ),
                AppTextfield(
                  prefixIcon: Icon(
                    Icons.title,
                    color: AppColors.grayBackground3,
                  ),
                  hint: "Conference Title",
                  controller: holderName,
                ),
                AppTextfield(
                  prefixIcon: Icon(
                    Icons.date_range_outlined,
                    color: AppColors.grayBackground3,
                  ),
                  hint: "Place and Title",
                  controller: placeAndTitle,
                ),
                AppTextfield(
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: AppColors.grayBackground3,
                  ),
                  hint: "Signature",
                  controller: placeAndTitle,
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
