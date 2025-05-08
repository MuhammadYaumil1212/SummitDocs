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
  final int roleId;
  final String title;
  FilesReceiptScreen({super.key, required this.roleId, required this.title});

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
      "Received From",
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
              _buildHeader(context, title),
              const SizedBox(height: 20),
              _buildTable("Peserta"),
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
          text: "Receipt \n$title",
          fontWeight: FontWeight.w700,
          fontSize: 30,
        ),
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
          columns: _buildColumns(title),
          data: conferences,
          rowBuilder: (conference) => _buildRow(conference, title),
        ),
      ],
    );
  }

  List<DataColumn> _buildColumns(String sectionTitle) {
    final isPeserta = sectionTitle.toLowerCase() == 'peserta';

    final columns = [
      _centeredColumn("Received From"),
      _centeredColumn("Amount"),
      _centeredColumn("In Payment of"),
      _centeredColumn("Payment Date"),
      _centeredColumn("Invoice No."),
      _centeredColumn("Conference Title"),
      _centeredColumn("User Conference Title"),
      _centeredColumn("Place and date"),
    ];

    if (!isPeserta) {
      columns.add(_centeredColumn("Signature"));
    }

    columns.add(_centeredColumn("Tindakan"));

    return columns;
  }

  DataColumn _centeredColumn(String title) {
    return DataColumn(
      label: Center(child: AppText(text: title)),
    );
  }

  DataRow _buildRow(ReceiptEntity conference, String sectionTitle) {
    final isPeserta = sectionTitle.toLowerCase() == 'peserta';

    final cells = [
      DataCell(
          Center(child: AppText(text: conference.receivedFrom.toString()))),
      DataCell(Center(child: AppText(text: conference.amount))),
      DataCell(Center(child: AppText(text: conference.conferenceTitle))),
      DataCell(Center(child: AppText(text: conference.inPaymentOf))),
      DataCell(Center(child: AppText(text: conference.paymentDate))),
      DataCell(Center(child: AppText(text: conference.invoiceNo))),
      DataCell(Center(child: AppText(text: conference.conferenceTitle))),
      DataCell(Center(child: AppText(text: conference.placeAndDate))),
    ];

    if (!isPeserta) {
      cells.add(DataCell(
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ActionButton(icon: AppString.infoIcon, action: () {}),
            ],
          ),
        ),
      ));
    }

    cells.add(DataCell(
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
    ));

    return DataRow(cells: cells);
  }
}
