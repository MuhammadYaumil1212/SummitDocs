import 'package:SummitDocs/Presentations/invoice/bloc/invoice_bloc.dart';
import 'package:SummitDocs/core/helper/message/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

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

  final List<InvoiceEntity> conferences = [];

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.roleId == 3
        ? _bloc.add(GetInvoiceIcicytaListEvent())
        : _bloc.add(GetInvoiceIcodsaListEvent());
  }

  void reloadAll() {
    setState(() {
      conferences.clear();
      conferences.map((element) {
        textfieldValueEdit(element);
      });
    });
    widget.roleId == 3
        ? _bloc.add(GetInvoiceIcicytaListEvent())
        : _bloc.add(GetInvoiceIcodsaListEvent());
    ;
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
            conferences
              ..clear()
              ..addAll(state.data);
          });
          conferences.map((element) {
            textfieldValueEdit(element);
          });
        } else if (state is FailedState) {
          return DisplayMessage.errorMessage(state.message, context);
        }
        if (state is FailedUpdateInvoiceIcicyta) {
          Navigator.of(context).pop();
          state.message.map((item) {
            return DisplayMessage.errorMessage(item, context);
          }).toList();
        }

        if (state is SuccessUpdateInvoiceIcicyta) {
          Navigator.of(context).pop();
          reloadAll();
          return DisplayMessage.successMessage(state.message, context);
        }

        if (state is SuccessUpdateInvoiceIcodsa) {
          Navigator.of(context).pop();
          reloadAll();
          return DisplayMessage.successMessage(state.message, context);
        }

        if (state is FailedUpdateInvoiceIcodsa) {
          Navigator.of(context).pop();
          state.message.map((item) {
            return DisplayMessage.errorMessage(item, context);
          }).toList();
        }

        if (state is UpdateInvoiceIcicytaState) {
          Navigator.of(context).pop();
          reloadAll();
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
                ActionButton(icon: AppString.downloadIcon, action: () {}),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showEditInvoice(BuildContext context, InvoiceEntity invoice) {
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
                        AppTextfield(
                          prefixIcon: Icon(
                            Icons.numbers_outlined,
                            color: AppColors.grayBackground3,
                          ),
                          keyboardType: TextInputType.number,
                          hint: "Virtual Account ID",
                          controller: virtualAccID,
                        ),
                        AppTextfield(
                          prefixIcon: Icon(
                            Icons.numbers_outlined,
                            color: AppColors.grayBackground3,
                          ),
                          keyboardType: TextInputType.number,
                          hint: "Bank Transfer ID",
                          controller: bankTransferID,
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
                              ? ["Pending", "Paid", "Unpaid"]
                              : status.text == "Paid"
                                  ? ["Paid", "Pending", "Unpaid"]
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
}
