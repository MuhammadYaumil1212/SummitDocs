import 'dart:async';

import 'package:SummitDocs/Presentations/receipt/bloc/receipt_bloc.dart';
import 'package:SummitDocs/core/helper/message/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Domain/receipt/entity/receipt_entity.dart';
import '../../../commons/constants/string.dart';
import '../../../commons/widgets/app_button.dart';
import '../../../commons/widgets/app_datatable.dart';
import '../../../commons/widgets/app_scaffold.dart';
import '../../../commons/widgets/app_text.dart';
import '../../../core/config/theme/app_colors.dart';

class FilesReceiptScreen extends StatefulWidget {
  final int roleId;
  final String title;

  FilesReceiptScreen({super.key, required this.roleId, required this.title});

  @override
  State<FilesReceiptScreen> createState() => _FilesReceiptScreenState();
}

class _FilesReceiptScreenState extends State<FilesReceiptScreen> {
  final ReceiptBloc _bloc = ReceiptBloc();

  final TextEditingController virtualAccountNumber = TextEditingController();

  final TextEditingController holderName = TextEditingController();

  final TextEditingController nameBank = TextEditingController();

  final TextEditingController nameBranch = TextEditingController();

  final TextEditingController paymentDate = TextEditingController();

  final TextEditingController placeAndTitle = TextEditingController();

  final List<ReceiptEntity> conferences = [];

  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  Completer<void>? _refreshCompleter;

  void reloadAll() {
    setState(() {
      conferences.clear();
    });
    widget.roleId == 3
        ? _bloc.add(GetAllReceiptIcicytaEvent())
        : _bloc.add(GetAllReceiptIcodsaEvent());
  }

  Future<void> _handleRefresh() async {
    _refreshCompleter = Completer<void>();
    await Future.delayed(Duration(seconds: 2));
    reloadAll();
    return _refreshCompleter!.future;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.roleId == 3
          ? _bloc.add(GetAllReceiptIcicytaEvent())
          : _bloc.add(GetAllReceiptIcodsaEvent());
      _refreshKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bloc: _bloc,
      listener: (context, state) {
        if (state is SuccessTable) {
          setState(() {
            conferences.clear();
            final sortedInvoices = List<ReceiptEntity>.from(state.data)
              ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
            for (var invoice in sortedInvoices) {
              conferences.add(invoice);
            }
            _refreshCompleter?.complete();
          });
        } else if (state is FailedTable) {
          _refreshCompleter?.complete();

          return DisplayMessage.errorMessage(state.message, context);
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
      appWidget: BlocBuilder<ReceiptBloc, ReceiptState>(
        builder: (context, state) {
          return RefreshIndicator(
            key: _refreshKey,
            onRefresh: _handleRefresh,
            color: AppColors.primary,
            child: ListView(
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                Padding(
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
              ],
            ),
          );
        },
      ),
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

  void _showDetailLoaIcicyta(ReceiptEntity detail) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white,
          title: AppText(
            text: "Detail Receipt",
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow("No.Invoice", detail.invoiceNo ?? "-"),
                _buildDetailRow("Received From", detail.receivedFrom ?? "-"),
                _buildDetailRow("Conference Title", detail.paperTitle ?? "-"),
                _buildDetailRow("Amount", detail.amount ?? "-"),
                _buildDetailRow("In Payment Of", detail.inPaymentOf ?? "-"),
                _buildDetailRow("Tanggal Pembayaran", detail.paymentDate ?? ""),
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
                columns: _buildColumns(title),
                data: conferences,
                rowBuilder: (conference) => _buildRow(conference, title),
              )
            : Center(
                child: AppText(text: "Please Wait....."),
              ),
      ],
    );
  }

  List<DataColumn> _buildColumns(String sectionTitle) {
    final isPeserta = sectionTitle.toLowerCase() == 'peserta';

    final columns = [
      _centeredColumn("Invoice No."),
      _centeredColumn("Received From"),
      _centeredColumn("Conference Title"),
      _centeredColumn("Amount"),
      _centeredColumn("In Payment of"),
      _centeredColumn("Tanggal Pembayaran"),
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
      DataCell(AppText(text: conference.invoiceNo ?? "-")),
      DataCell(AppText(text: conference.receivedFrom.toString())),
      DataCell(AppText(text: conference.paperTitle ?? "")),
      DataCell(AppText(text: conference.amount ?? "Rp.0")),
      DataCell(AppText(text: conference.inPaymentOf ?? "-")),
      DataCell(AppText(text: conference.paymentDate ?? "-")),
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
            ActionButton(
                icon: AppString.infoIcon,
                action: () {
                  _showDetailLoaIcicyta(conference);
                }),
            const SizedBox(width: 10),
            ActionButton(
              icon: AppString.downloadIcon,
              action: () {
                DisplayMessage.errorMessage(
                  "Sedang dalam pengembangan",
                  context,
                );
              },
              backgroundColor: Colors.grey,
            ),
          ],
        ),
      ),
    ));

    return DataRow(cells: cells);
  }
}
