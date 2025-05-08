import 'package:SummitDocs/Presentations/invoice/bloc/invoice_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Domain/home/entities/invoice_entity.dart';
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
  final List<InvoiceEntity> conferences = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.add(GetInvoiceIcicytaListEvent());
  }

  void reloadAll() {
    conferences.clear();
    _bloc.add(GetInvoiceIcicytaListEvent());
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    reloadAll();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bloc: _bloc,
      listener: (context, state) {
        if (state is SuccessState) {
          setState(() {
            conferences.addAll(state.data);
          });
        } else if (state is FailedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: AppText(text: state.message),
            ),
          );
        }
      },
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
      appWidget: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: AppColors.primary,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, widget.title),
                const SizedBox(height: 20),
                _buildTable("Peserta", conferences),
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
          text: "Invoice \n${title}",
          fontWeight: FontWeight.w700,
          fontSize: 30,
        ),
      ],
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
                data: conferences,
                rowBuilder: _buildRow,
              )
            : Center(
                child: AppText(text: "Please wait......"),
              ),
      ],
    );
  }

  void _showDetailInvoiceIcicyta(InvoiceEntity detail) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white,
          title: AppText(
            text: "Detail Invoice",
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow("No.Invoice", detail.invoiceNo ?? "-"),
                _buildDetailRow(
                  "LOA ID",
                  detail.loaId != null ? detail.loaId.toString() : "-",
                ),
                _buildDetailRow("Institusi", detail.institution ?? "-"),
                _buildDetailRow(
                    "Virtual Account ID",
                    detail.virtualAccountId != null
                        ? detail.virtualAccountId.toString()
                        : "-"),
                _buildDetailRow(
                    "Bank Transfer ID",
                    detail.bankTransferId != null
                        ? detail.bankTransferId.toString()
                        : "-"),
                _buildDetailRow("Email", detail.email ?? "-"),
                _buildDetailRow("Tanggal", detail.dateOfIssue ?? "-"),
                _buildDetailRow("Status", detail.status ?? "-"),
                _buildDetailRow("amount", detail.amount ?? "Rp.0"),
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: AppText(
        text: "$label: $value",
      ),
    );
  }

  List<DataColumn> _buildColumns() {
    return [
      _centeredColumn("No.Invoice"),
      _centeredColumn("Institusi"),
      _centeredColumn("Email"),
      _centeredColumn("Tanggal"),
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
        DataCell(AppText(text: conference.invoiceNo ?? "-")),
        DataCell(AppText(text: conference.institution ?? "-")),
        DataCell(AppText(text: conference.email ?? "-")),
        DataCell(AppText(text: conference.dateOfIssue ?? "-")),
        DataCell(AppText(text: conference.status ?? "-")),
        DataCell(
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionButton(
                    icon: AppString.infoIcon,
                    action: () {
                      _showDetailInvoiceIcicyta(conference);
                    }),
                const SizedBox(width: 10),
                ActionButton(
                    icon: AppString.editIcon,
                    action: () {
                      _showDetailInvoiceIcicyta(conference);
                    }),
                const SizedBox(width: 10),
                ActionButton(icon: AppString.downloadIcon, action: () {}),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
