import 'package:SummitDocs/Presentations/transfer_virtual/bloc/transfer_virtual_bloc.dart';
import 'package:SummitDocs/Presentations/transfer_virtual/transfer_virtual_entity.dart';
import 'package:SummitDocs/commons/widgets/app_button.dart';
import 'package:SummitDocs/commons/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../commons/constants/string.dart';
import '../../../commons/widgets/app_datatable.dart';
import '../../../commons/widgets/app_text.dart';
import '../../../core/config/theme/app_colors.dart';

class TransferVirtual extends StatefulWidget {
  const TransferVirtual({super.key});

  @override
  State<TransferVirtual> createState() => _TransferVirtualState();
}

class _TransferVirtualState extends State<TransferVirtual> {
  final List<TransferVirtualEntity> conferences = List.generate(
    15,
    (index) => TransferVirtualEntity(
      id: index + 1,
      AccountHolderName: "Holder",
      BankBranch: "branch bank",
      BankName: "Bank name",
      NoVirtualAcc: "123456",
    ),
  );

  Widget _buildHeader(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          text: title,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
        AppDropdownButton(
          items: const ["Virtual Account", "Bank Transfer"],
          onSelected: (value) {
            switch (value) {
              case "Virtual Account":
                // Handle Virtual Account selection
                break;
              case "Bank Transfer":
                // Handle Bank Transfer selection
                break;
            }
          },
          buttonText: 'Tambah data',
        )
      ],
    );
  }

  List<DataColumn> _buildColumns() {
    return [
      _centeredColumn("ID"),
      _centeredColumn("No.Virtual acc"),
      _centeredColumn("Account Holder Name"),
      _centeredColumn("Bank Name"),
      _centeredColumn("Bank Branch"),
      _centeredColumn("Tindakan"),
    ];
  }

  Widget _buildTable(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: title,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 10),
        AppDataTable(
          columns: _buildColumns(),
          data: conferences,
          rowBuilder: _buildRow,
        ),
      ],
    );
  }

  DataRow _buildRow(TransferVirtualEntity tve) {
    return DataRow(
      cells: [
        DataCell(Center(child: AppText(text: tve.id.toString()))),
        DataCell(Center(child: AppText(text: tve.NoVirtualAcc))),
        DataCell(Center(child: AppText(text: tve.AccountHolderName))),
        DataCell(Center(child: AppText(text: tve.BankName))),
        DataCell(Center(child: AppText(text: tve.BankBranch))),
        DataCell(
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionButton(
                  icon: AppString.infoIcon,
                  backgroundColor: AppColors.primary,
                  action: () {},
                ),
                const SizedBox(width: 5),
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

  DataColumn _centeredColumn(String title) {
    return DataColumn(
      label: Center(
        child: AppText(text: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bloc: TransferVirtualBloc(),
      listener: (BuildContext context, TransferVirtualState state) {},
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
      appWidget: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildHeader(context, "Transfer/\nVirtual Account"),
              const SizedBox(height: 30),
              _buildTable("Virtual Account"),
              _buildTable("Bank Transfer"),
            ],
          ),
        ),
      ),
    );
  }
}
