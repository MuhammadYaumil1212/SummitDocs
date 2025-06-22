import 'dart:async';
import 'dart:io';

import 'package:SummitDocs/Domain/transfer_virtual/entity/account_virtual_entity.dart';
import 'package:SummitDocs/Domain/transfer_virtual/entity/transfer_virtual_entity.dart';
import 'package:SummitDocs/Presentations/invoice/bloc/invoice_bloc.dart';
import 'package:SummitDocs/core/helper/message/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;

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
  TextEditingController invoiceNumber = TextEditingController();
  TextEditingController LoaID = TextEditingController();
  TextEditingController institution = TextEditingController();
  TextEditingController virtualAccID = TextEditingController();
  TextEditingController bankTransferID = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController dateOfIssue = TextEditingController();
  TextEditingController status = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController presentationType = TextEditingController();
  TextEditingController memberType = TextEditingController();
  TextEditingController authorType = TextEditingController();

  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  Completer<void>? _refreshCompleter;

  final List<InvoiceEntity> conferences = [];
  final List<AccountVirtualEntity> virtualAccount = [];
  final List<TransferVirtualEntity> banks = [];

  void textfieldValueEdit(InvoiceEntity entity) {
    invoiceNumber.text = entity.invoiceNo ?? "";
    LoaID.text = entity.loaId.toString();
    institution.text = entity.institution ?? "";
    virtualAccID.text = entity.virtualAccountId != null
        ? entity.virtualAccountId.toString()
        : "";
    bankTransferID.text =
        entity.bankTransferId != null ? entity.bankTransferId.toString() : "";
    email.text = entity.email ?? "";
    dateOfIssue.text = entity.dateOfIssue ?? "";
    status.text = entity.status ?? "";
    amount.text = (entity.amount != null && entity.amount != 0)
        ? entity.amount.toString()
        : "0";
    presentationType.text = entity.presentationType.toString();
    memberType.text = entity.memberType.toString();
    authorType.text = entity.authorType ?? "";
  }

  void clearAll() {
    conferences.clear();
    invoiceNumber.clear();
    LoaID.clear();
    institution.clear();
    virtualAccID.clear();
    bankTransferID.clear();
    email.clear();
    dateOfIssue.clear();
    status.clear();
    amount.clear();
    presentationType.clear();
    memberType.clear();
    authorType.clear();
  }

  String getOrdinal(int n) {
    if (n % 100 >= 11 && n % 100 <= 13) return "${n}th";
    switch (n % 10) {
      case 1:
        return "${n}st";
      case 2:
        return "${n}nd";
      case 3:
        return "${n}rd";
      default:
        return "${n}th";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc.add(LoadVirtualAccount());
      _bloc.add(LoadTransferBankVirtual());
      widget.roleId == 3
          ? _bloc.add(GetInvoiceIcicytaListEvent())
          : _bloc.add(GetInvoiceIcodsaListEvent());
      _refreshKey.currentState?.show();
    });
  }

  void reloadAll() {
    setState(() {
      conferences.clear();
      virtualAccount.clear();
      banks.clear();
      conferences.map((element) {
        textfieldValueEdit(element);
      });
    });
    _bloc.add(LoadVirtualAccount());
    _bloc.add(LoadTransferBankVirtual());
    widget.roleId == 3
        ? _bloc.add(GetInvoiceIcicytaListEvent())
        : _bloc.add(GetInvoiceIcodsaListEvent());
  }

  Future<void> _handleRefresh() async {
    _refreshCompleter = Completer<void>();
    await Future.delayed(Duration(seconds: 2));
    reloadAll();
    return _refreshCompleter!.future;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bloc: _bloc,
      listener: (context, state) {
        if (state is SuccessVirtualAccount) {
          setState(() {
            virtualAccount
              ..clear()
              ..addAll(state.accountVirtual);
          });

          _refreshCompleter?.complete();
        }
        if (state is SuccessTransfer) {
          setState(() {
            banks
              ..clear()
              ..addAll(state.transferVirtual);
          });
          _refreshCompleter?.complete();
        }
        if (state is SuccessState) {
          setState(() {
            conferences
              ..clear()
              ..addAll(state.data);
          });
          _refreshCompleter?.complete();
          conferences.map((element) {
            textfieldValueEdit(element);
          });
        } else if (state is FailedState) {
          _refreshCompleter?.complete();

          return DisplayMessage.errorMessage(state.message, context);
        }
        if (state is FailedUpdateInvoiceIcicyta) {
          Navigator.of(context).pop();
          state.message.map((item) {
            return DisplayMessage.errorMessage(item, context);
          }).toList();
          _refreshCompleter?.complete();
        }

        if (state is SuccessUpdateInvoiceIcicyta) {
          Navigator.of(context).pop();
          reloadAll();
          _refreshCompleter?.complete();
          return DisplayMessage.successMessage(state.message, context);
        }

        if (state is SuccessUpdateInvoiceIcodsa) {
          Navigator.of(context).pop();
          reloadAll();
          _refreshCompleter?.complete();
          return DisplayMessage.successMessage(state.message, context);
        }

        if (state is FailedUpdateInvoiceIcodsa) {
          Navigator.of(context).pop();
          state.message.map((item) {
            return DisplayMessage.errorMessage(item, context);
          }).toList();
          _refreshCompleter?.complete();
        }

        if (state is UpdateInvoiceIcicytaState) {
          Navigator.of(context).pop();
          reloadAll();
          _refreshCompleter?.complete();
          return DisplayMessage.successMessage(state.message, context);
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
          key: _refreshKey,
          onRefresh: _handleRefresh,
          color: AppColors.primary,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
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
          )),
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

  PdfColor pdfColorFromFlutterColor(Color color) {
    return PdfColor.fromInt(color.value);
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
                      _showEditInvoice(context, conference);
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
        ),
      ],
    );
  }

  void _showEditInvoice(BuildContext context, InvoiceEntity invoice) {
    print("bank data : ${banks.length}");
    showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder<InvoiceBloc, InvoiceState>(
          bloc: _bloc,
          builder: (context, state) {
            final bool isLoading = state is UpdateInvoiceIcicytaLoadingState ||
                state is UpdateInvoiceIcodsaLoadingState && state.isLoading;
            textfieldValueEdit(invoice);
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.white,
              title: AppText(
                text: "Edit Data",
                fontSize: 21,
                fontWeight: FontWeight.w700,
              ),
              content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setStateDialog) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // AppTextfield(
                        //   prefixIcon: Icon(
                        //     Icons.numbers_outlined,
                        //     color: AppColors.grayBackground3,
                        //   ),
                        //   keyboardType: TextInputType.number,
                        //   hint: "Virtual Account ID",
                        //   controller: virtualAccID,
                        // ),
                        // AppTextfield(
                        //   prefixIcon: Icon(
                        //     Icons.numbers_outlined,
                        //     color: AppColors.grayBackground3,
                        //   ),
                        //   keyboardType: TextInputType.number,
                        //   hint: "Bank Transfer ID",
                        //   controller: bankTransferID,
                        // ),
                        AppDropdown(
                          label: virtualAccID.text.isEmpty
                              ? "Virtual Account"
                              : virtualAccID.text,
                          labelColor: virtualAccID.text.isEmpty
                              ? Colors.grey
                              : Colors.black,
                          items: virtualAccount
                              .map((e) => "${e.id} - ${e.nomorVirtualAkun}")
                              .toList(),
                          onChanged: (value) {
                            final selectedId = value?.split(" - ").first;
                            virtualAccID.text = selectedId ?? "";
                            print("Selected Virtual Account ID: $selectedId");
                          },
                        ),

                        AppDropdown(
                          label: bankTransferID.text.isEmpty
                              ? "Bank Transfer"
                              : bankTransferID.text,
                          labelColor: bankTransferID.text.isEmpty
                              ? Colors.grey
                              : Colors.black,
                          items: banks
                              .map((e) =>
                                  "${e.id} - ${e.beneficiaryBankAccountNo}")
                              .toList(),
                          onChanged: (value) {
                            final selectedId = value?.split(" - ").first;
                            bankTransferID.text = selectedId ?? "";
                            print("Selected Bank Transfer ID: $selectedId");
                          },
                        ),
                        AppTextfield(
                          prefixIcon: Icon(
                            Icons.pin_outlined,
                            color: AppColors.grayBackground3,
                          ),
                          hint: "No Invoice",
                          controller: invoiceNumber,
                        ),
                        AppTextfield(
                          prefixIcon: Icon(
                            Icons.school_outlined,
                            color: AppColors.grayBackground3,
                          ),
                          hint: "Institusi",
                          controller: institution,
                        ),
                        AppTextfield(
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: AppColors.grayBackground3,
                          ),
                          hint: "Email",
                          controller: email,
                        ),
                        AppDatePicker(
                          dateController: dateOfIssue,
                          hint: "Tanggal",
                          value: (value) {
                            value = value.trim();
                            DateFormat inputFormat = DateFormat('dd/MM/yyyy');
                            DateTime selectedDate =
                                inputFormat.parseStrict(value);

                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(selectedDate);

                            dateOfIssue.text = formattedDate;
                            print("tanggal : $formattedDate");
                          },
                        ),
                        AppTextfield(
                          prefixIcon: Icon(
                            Icons.numbers_outlined,
                            color: AppColors.grayBackground3,
                          ),
                          keyboardType: TextInputType.number,
                          hint: "Amount",
                          controller: amount,
                        ),
                        AppTextfield(
                          prefixIcon: Icon(
                            Icons.edit_outlined,
                            color: AppColors.grayBackground3,
                          ),
                          hint: "Tipe Penulis",
                          controller: authorType,
                        ),
                        AppDropdown(
                          label: status.text.isEmpty || status.text == "null"
                              ? "Status"
                              : status.text,
                          labelColor:
                              status.text.isEmpty || status.text == "null"
                                  ? Colors.grey
                                  : Colors.black,
                          items: status.text == "Pending"
                              ? ["Pending", "Paid"]
                              : status.text == "Paid"
                                  ? ["Paid", "Pending"]
                                  : status.text == "Unpaid"
                                      ? ["Unpaid", "Pending", "Paid"]
                                      : ["Pending", "Paid", "Unpaid"],
                          onChanged: (value) {
                            status.text = value ?? "";
                            print("Selected: $value");
                          },
                        ),
                        AppDropdown(
                          label: memberType.text.isEmpty ||
                                  memberType.text == "null"
                              ? "Tipe Member"
                              : memberType.text,
                          labelColor: memberType.text.isEmpty ||
                                  memberType.text == "null"
                              ? Colors.grey
                              : Colors.black,
                          items: memberType.text == "IEEE Member"
                              ? ["IEEE Member", "IEEE Non Member"]
                              : memberType.text == "IEEE Non Member"
                                  ? ["IEEE Non Member", "IEEE Member"]
                                  : ["IEEE Member", "IEEE Non Member"],
                          onChanged: (value) {
                            memberType.text = value ?? "";
                            print("Selected: $value");
                          },
                        ),
                        AppDropdown(
                          label: presentationType.text.isEmpty ||
                                  presentationType.text == "null"
                              ? "Tipe Presentasi"
                              : presentationType.text,
                          labelColor: presentationType.text.isEmpty ||
                                  presentationType.text == "null"
                              ? Colors.grey
                              : Colors.black,
                          items: presentationType.text == "Online"
                              ? ["Online", "Onsite"]
                              : presentationType.text == "Onsite"
                                  ? ["Onsite", "Online"]
                                  : ["Online", "Onsite"],
                          onChanged: (value) {
                            presentationType.text = value ?? "";
                            print("Selected: $value");
                          },
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: AppButton(
                            text: "Ubah",
                            isLoading: isLoading,
                            action: () {
                              widget.roleId == 3
                                  ? _bloc.add(
                                      SubmitUpdateInvoiceIcicyta(
                                        invoice.id ?? -1,
                                        institution.text,
                                        email.text,
                                        presentationType.text,
                                        memberType.text,
                                        authorType.text,
                                        amount.text,
                                        dateOfIssue.text,
                                        int.tryParse(virtualAccID.text),
                                        int.tryParse(bankTransferID.text),
                                        status.text,
                                      ),
                                    )
                                  : _bloc.add(
                                      SubmitUpdateInvoiceIcodsa(
                                        invoice.id ?? -1,
                                        institution.text,
                                        email.text,
                                        presentationType.text,
                                        memberType.text,
                                        authorType.text,
                                        amount.text,
                                        dateOfIssue.text,
                                        int.tryParse(virtualAccID.text),
                                        int.tryParse(bankTransferID.text),
                                        status.text,
                                      ),
                                    );
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: AppButton(
                            action: () {
                              Navigator.of(context).pop();
                              clearAll();
                            },
                            text: "Batalkan",
                            borderColor: AppColors.grayBackground2,
                            backgroundColor: AppColors.secondaryBackground,
                            fontColor: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Future<void> generateLoAICICYTADocument(
      {required InvoiceEntity conference}) async {
    final pdf = pw.Document();
    // Load images
    final ByteData teluLogoBytes = await rootBundle.load(AppString.logoTelyu);
    final ByteData unbiLogoBytes = await rootBundle.load(AppString.logoUb);
    final ByteData utmLogoBytes = await rootBundle.load(AppString.logoUtm);
    final ByteData icodsaLogoBytes = await rootBundle.load(
      AppString.icodsaLogo,
    );

    final teluLogo = pw.MemoryImage(teluLogoBytes.buffer.asUint8List());
    final unbiLogo = pw.MemoryImage(unbiLogoBytes.buffer.asUint8List());
    final utmLogo = pw.MemoryImage(utmLogoBytes.buffer.asUint8List());
    final icodsaLogo = pw.MemoryImage(icodsaLogoBytes.buffer.asUint8List());

    final currentDate = DateTime.now();
    final currentYear = currentDate.year;
    const startYear = 2018;
    final editionNumber = currentYear - startYear + 1;

    final String displayPlaceDate = DateFormat('MMMM dd, yyyy').format(
      conference.createdAt!,
    );

    String formatAuthorNames(List<String>? names) {
      if (names == null || names.isEmpty) return '';
      final filtered =
          names.where((n) => n.trim().isNotEmpty).map((n) => n.trim()).toList();

      if (filtered.isEmpty) return '';
      if (filtered.length == 1) return filtered[0];
      if (filtered.length == 2) return '${filtered[0]} and ${filtered[1]}';

      final allExceptLast = filtered.sublist(0, filtered.length - 1).join(', ');
      final last = filtered.last;

      return '$allExceptLast and $last';
    }

    pdf.addPage(
      widget.roleId == 3
          ? pw.Page(
              pageFormat: PdfPageFormat.a4,
              margin: pw.EdgeInsets.zero,
              build: (pw.Context context) {
                return pw.Column(children: []);
              },
            )
          : pw.Page(
              pageFormat: PdfPageFormat.a4,
              margin: pw.EdgeInsets.zero,
              build: (pw.Context context) {
                return pw.Column(children: []);
              }),
    );

    // Save the PDF
    final directory = await getApplicationDocumentsDirectory();
    final file = File(
        '${directory.path}/Invoice_${widget.roleId == 3 ? "ICICYTA" : "ICODSA"}_${conference.invoiceNo}.pdf');
    await file.writeAsBytes(await pdf.save());
    // Open the PDF
    OpenFile.open(file.path);
  }
}
