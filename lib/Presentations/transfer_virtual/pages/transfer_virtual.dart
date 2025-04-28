import 'package:SummitDocs/Domain/transfer_virtual/entity/account_virtual_entity.dart';
import 'package:SummitDocs/Domain/transfer_virtual/entity/transfer_virtual_entity.dart';
import 'package:SummitDocs/Presentations/transfer_virtual/bloc/transfer_virtual_bloc.dart';
import 'package:SummitDocs/commons/widgets/app_button.dart';
import 'package:SummitDocs/commons/widgets/app_scaffold.dart';
import 'package:SummitDocs/commons/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../commons/constants/string.dart';
import '../../../commons/widgets/app_datatable.dart';
import '../../../commons/widgets/app_text.dart';
import '../../../core/config/theme/app_colors.dart';
import '../../../core/helper/message/message.dart';

class TransferVirtual extends StatefulWidget {
  const TransferVirtual({super.key});

  @override
  State<TransferVirtual> createState() => _TransferVirtualState();
}

class _TransferVirtualState extends State<TransferVirtual> {
  final _bloc = TransferVirtualBloc();
  final TextEditingController _bankName = TextEditingController();
  final TextEditingController _swiftCode = TextEditingController();
  final TextEditingController _recipientName = TextEditingController();
  final TextEditingController _beneficiaryBankAccNo = TextEditingController();
  final TextEditingController _bankAddress = TextEditingController();
  final TextEditingController _bankBranch = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _country = TextEditingController();

  final TextEditingController _novirtualAcc = TextEditingController();
  final TextEditingController _accountHolderName = TextEditingController();
  final TextEditingController _bankNameVirtual = TextEditingController();
  final TextEditingController _bankBranchVirtual = TextEditingController();

  late final List<TransferVirtualEntity> bankData = [];
  late final List<AccountVirtualEntity> virtualAccountData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.add(LoadTransferBankVirtual());
    _bloc.add(LoadVirtualAccount());
  }

  void clearAll() {
    _bankName.clear();
    _swiftCode.clear();
    _recipientName.clear();
    _beneficiaryBankAccNo.clear();
    _bankAddress.clear();
    _bankBranch.clear();
    _city.clear();
    _country.clear();

    _novirtualAcc.clear();
    _accountHolderName.clear();
    _bankNameVirtual.clear();
    _bankBranchVirtual.clear();
  }

  Widget _buildHeader(
      BuildContext context, String title, TransferVirtualState state) {
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
                _showVirtualAccountAddDataDialog(context);
                break;
              case "Bank Transfer":
                // Handle Bank Transfer selection
                _showBankTransferAddDataDialog(context, state);
                break;
            }
          },
          buttonText: 'Tambah data',
        )
      ],
    );
  }

  List<DataColumn> _buildVirtualColumns() {
    return [
      _centeredColumn("ID"),
      _centeredColumn("No.Virtual acc"),
      _centeredColumn("Account Holder Name"),
      _centeredColumn("Bank Name"),
      _centeredColumn("Bank Branch"),
      _centeredColumn("Tindakan"),
    ];
  }

  List<DataColumn> _buildBankColumns() {
    return [
      _centeredColumn("ID"),
      _centeredColumn("Bank Name"),
      _centeredColumn("Swift Code"),
      _centeredColumn("Recipient Name"),
      _centeredColumn("Beneficiary Bank Acc No."),
      _centeredColumn("Tindakan"),
    ];
  }

  Widget _buildTable<T>(
    List<DataColumn> columns,
    DataRow Function(T) row,
    String title,
    List<T> listTransferBank,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: title,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 10),
        listTransferBank.isNotEmpty
            ? AppDataTable(
                columns: columns,
                data: listTransferBank,
                rowBuilder: row,
                rowsPerPage: 10,
              )
            : Center(
                child: AppText(text: "Please Wait....."),
              ),
      ],
    );
  }

  DataRow _buildBankRow(TransferVirtualEntity tve) {
    return DataRow(
      cells: [
        DataCell(AppText(text: tve.id.toString())),
        DataCell(AppText(text: tve.namaBank ?? "-")),
        DataCell(AppText(text: tve.swiftCode ?? "-")),
        DataCell(AppText(text: tve.recipientName ?? "-")),
        DataCell(AppText(text: tve.beneficiaryBankAccountNo ?? "-")),
        DataCell(
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionButton(
                  icon: AppString.infoIcon,
                  backgroundColor: AppColors.primary,
                  action: () {
                    _bloc.add(LoadDetailBank(id: tve.id ?? -1));
                    _showDetailBankDialog(tve.id ?? -1, tve);
                  },
                ),
                const SizedBox(width: 5),
                ActionButton(
                    icon: AppString.trashIcon,
                    backgroundColor: AppColors.redFailed,
                    action: () => _showDeleteDialog(tve.id ?? -1))
              ],
            ),
          ),
        ),
      ],
    );
  }

  DataRow _buildVirtualRow(AccountVirtualEntity tve) {
    return DataRow(
      cells: [
        DataCell(AppText(text: tve.id.toString())),
        DataCell(AppText(text: tve.nomorVirtualAkun ?? "-")),
        DataCell(AppText(text: tve.accountHolderName ?? "-")),
        DataCell(AppText(text: tve.bankName ?? "-")),
        DataCell(AppText(text: tve.bankBranch ?? "-")),
        DataCell(
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionButton(
                  icon: AppString.infoIcon,
                  backgroundColor: AppColors.primary,
                  action: () {
                    _bloc.add(LoadDetailBank(id: tve.id ?? -1));
                    _showDetailVirtualDialog(tve.id ?? -1, tve);
                  },
                ),
                const SizedBox(width: 5),
                ActionButton(
                    icon: AppString.trashIcon,
                    backgroundColor: AppColors.redFailed,
                    action: () => _showDeleteDialog(tve.id ?? -1))
              ],
            ),
          ),
        ),
      ],
    );
  }

  DataColumn _centeredColumn(String title) {
    return DataColumn(
      label: AppText(text: title),
    );
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    reloadData();
  }

  void reloadData({int id = -1}) {
    setState(() {
      bankData.clear();
      virtualAccountData.clear();
      clearAll();
      _bloc.add(LoadTransferBankVirtual());
      _bloc.add(LoadDetailBank(id: id));
      _bloc.add(LoadVirtualAccount());
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bloc: _bloc,
      listener: (BuildContext context, TransferVirtualState state) {
        if (state is SuccessTransfer) {
          setState(() {
            bankData.clear();
            final sortedData =
                List<TransferVirtualEntity>.from(state.transferVirtual)
                  ..sort(
                    (a, b) => (b.createdAt ?? DateTime(0))
                        .compareTo(a.createdAt ?? DateTime(0)),
                  );
            bankData.addAll(sortedData);
          });
          state.transferVirtual.map((item) {
            DisplayMessage.successMessage(
              "Berhasil menambahkan ${item.namaBank}",
              context,
            );
          });
        }

        if (state is SuccessVirtualAccount) {
          setState(() {
            virtualAccountData.clear();
            final sortedData =
                List<AccountVirtualEntity>.from(state.accountVirtual)
                  ..sort(
                    (a, b) => (b.createdAt ?? DateTime(0))
                        .compareTo(a.createdAt ?? DateTime(0)),
                  );
            virtualAccountData.addAll(sortedData);
          });

          state.accountVirtual.map((item) {
            DisplayMessage.successMessage(
              "Berhasil menambahkan ${item.bankName}",
              context,
            );
          });
        }

        if (state is SuccessSendVirtualAccount) {
          DisplayMessage.successMessage(state.successMessage, context);
        }

        if (state is SuccessDeleteData) {
          reloadData();
          return DisplayMessage.successMessage(state.successMessage, context);
        }

        if (state is FailedSendData) {
          state.errorMessage.map((item) {
            return DisplayMessage.errorMessage(item, context);
          }).toList();
        }

        if (state is FailedSendVirtualAccount) {
          state.errorMessage.map((item) {
            return DisplayMessage.errorMessage(item, context);
          }).toList();
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
          child: Container(
            color: AppColors.grayBackground,
            height: 4.0,
          ),
        ),
      ),
      appWidget: BlocBuilder<TransferVirtualBloc, TransferVirtualState>(
        builder: (context, state) {
          if (state is LoadingTransfer) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }
          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: _handleRefresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildHeader(context, "Transfer/\nVirtual Account", state),
                    const SizedBox(height: 30),
                    _buildTable(
                      _buildVirtualColumns(),
                      _buildVirtualRow,
                      "Virtual Account",
                      virtualAccountData,
                    ),
                    _buildTable(
                      _buildBankColumns(),
                      _buildBankRow,
                      "Bank Transfer",
                      bankData,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showVirtualAccountAddDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder<TransferVirtualBloc, TransferVirtualState>(
          bloc: _bloc,
          builder: (context, state) {
            final bool isLoading =
                state is LoadingVirtualAccount && state.isLoading;
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppTextfield(
                      hint: "Nomor Virtual Account",
                      keyboardType: TextInputType.number,
                      controller: _novirtualAcc,
                    ),
                    AppTextfield(
                      hint: "Account Holder Name",
                      controller: _accountHolderName,
                    ),
                    AppTextfield(
                      hint: "Bank Name",
                      controller: _bankNameVirtual,
                    ),
                    AppTextfield(
                      hint: "Bank Branch",
                      controller: _bankBranchVirtual,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: AppButton(
                        text: "Simpan",
                        isLoading: isLoading,
                        action: () {
                          _bloc.add(
                            SendVirtualAccount(
                              noVirtualAccount: _novirtualAcc.text,
                              accountHolderName: _accountHolderName.text,
                              bankName: _bankNameVirtual.text,
                              bankBranch: _bankBranchVirtual.text,
                            ),
                          );
                          Future.delayed(Duration(seconds: 2), () {
                            reloadData();
                            Navigator.of(context).pop();
                          });
                        },
                      ),
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

  void _showBankTransferAddDataDialog(
      BuildContext context, TransferVirtualState state) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder<TransferVirtualBloc, TransferVirtualState>(
          bloc: _bloc,
          builder: (context, state) {
            final bool isLoading = state is LoadingTransfer && state.isLoading;
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppTextfield(
                      hint: "Bank Name",
                      controller: _bankName,
                    ),
                    AppTextfield(
                      hint: "Swift Code",
                      controller: _swiftCode,
                    ),
                    AppTextfield(
                      hint: "Recipient Name",
                      controller: _recipientName,
                    ),
                    AppTextfield(
                      hint: "Beneficiary Bank Account",
                      controller: _beneficiaryBankAccNo,
                    ),
                    AppTextfield(
                      hint: "Bank Branch",
                      controller: _bankBranch,
                    ),
                    AppTextfield(
                      hint: "Bank Address",
                      controller: _bankAddress,
                    ),
                    AppTextfield(
                      hint: "City",
                      controller: _city,
                    ),
                    AppTextfield(
                      hint: "Country",
                      controller: _country,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        text: "Simpan",
                        isLoading: isLoading,
                        action: () {
                          _bloc.add(SendBankTransferData(
                            namaBank: _bankName.text,
                            swiftCode: _swiftCode.text,
                            receipientName: _recipientName.text,
                            beneficiaryBankAccountNo:
                                _beneficiaryBankAccNo.text,
                            bankBranch: _bankBranch.text,
                            bankAddress: _bankAddress.text,
                            city: _city.text,
                            country: _country.text,
                          ));
                          Future.delayed(Duration(seconds: 2), () {
                            reloadData();
                            Navigator.of(context).pop();
                          });
                        },
                      ),
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

  void _showDeleteDialog(int id) {
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
                  text: "Apakah anda yakin ingin menghapus Bank ?",
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
                        _bloc.add(
                          DeleteTransferData(id: id),
                        );
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

  void _showDetailBankDialog(int id, TransferVirtualEntity detail) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white,
          title: AppText(
            text: "Detail Bank",
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow("ID", detail.id.toString()),
                _buildDetailRow("Bank Name", detail.namaBank ?? "-"),
                _buildDetailRow("Swift Code", detail.swiftCode ?? "-"),
                _buildDetailRow("Recipient Name", detail.recipientName ?? "-"),
                _buildDetailRow(
                    "Beneficiary", detail.beneficiaryBankAccountNo ?? "-"),
                _buildDetailRow("Bank Branch", detail.bankBranch ?? "-"),
                _buildDetailRow("Bank Address", detail.bankAddress ?? "-"),
                _buildDetailRow("City", detail.city ?? "-"),
                _buildDetailRow("Country", detail.country ?? "-"),
                _buildDetailRow("Tanggal dibuat",
                    DateFormat('dd/MM/yyyy').format(detail.createdAt!)),
                _buildDetailRow("Tanggal Diubah",
                    DateFormat('dd/MM/yyyy').format(detail.updatedAt!)),
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

  void _showDetailVirtualDialog(int id, AccountVirtualEntity detail) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white,
          title: AppText(
            text: "Detail Bank",
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow("ID", detail.id.toString()),
                _buildDetailRow(
                    "No. Virtual Account", detail.nomorVirtualAkun ?? "-"),
                _buildDetailRow(
                    "Account Holder", detail.accountHolderName ?? "-"),
                _buildDetailRow("Bank Name", detail.bankName ?? "-"),
                _buildDetailRow("Bank Branch", detail.bankBranch ?? "-"),
                _buildDetailRow(
                  "Tanggal dibuat",
                  DateFormat('dd/MM/yyyy').format(
                    detail.createdAt!,
                  ),
                ),
                _buildDetailRow(
                  "Tanggal Diubah",
                  DateFormat('dd/MM/yyyy').format(
                    detail.updatedAt!,
                  ),
                ),
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
}
