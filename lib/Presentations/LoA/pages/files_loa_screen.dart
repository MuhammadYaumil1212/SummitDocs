import 'dart:async';

import 'package:SummitDocs/Domain/LoA/entity/loa_entity.dart';
import 'package:SummitDocs/Domain/signature/entity/signature_entity.dart';
import 'package:SummitDocs/Presentations/manage_account/bloc/manage_account_bloc.dart';
import 'package:SummitDocs/commons/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:SummitDocs/commons/widgets/app_button.dart';
import 'package:SummitDocs/commons/widgets/app_text.dart';
import 'package:SummitDocs/core/config/theme/app_colors.dart';
import 'package:SummitDocs/Presentations/LoA/bloc/loa_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../commons/constants/string.dart';
import '../../../commons/widgets/app_datatable.dart';
import '../../../commons/widgets/app_scaffold.dart';
import '../../../core/helper/message/message.dart';

class FilesLoaScreen extends StatefulWidget {
  final int roleId;
  final String title;
  const FilesLoaScreen({super.key, required this.roleId, required this.title});

  @override
  State<FilesLoaScreen> createState() => _FilesLoaScreenState();
}

class _FilesLoaScreenState extends State<FilesLoaScreen> {
  final LoaBloc _bloc = LoaBloc();
  TextEditingController paperIdController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController conferenceTitleController = TextEditingController();
  TextEditingController writerController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController signatureController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  List<TextEditingController> authorControllers = [TextEditingController()];
  TextEditingController statusController = TextEditingController();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  Completer<void>? _refreshCompleter;
  final List<LoaEntity> conferences = [];
  final List<String> signatures = [];

  void reloadAll() {
    conferences.clear();
    _bloc.add(GetSignatureId());
    widget.roleId == 3
        ? _bloc.add(GetAllLoaEvent())
        : _bloc.add(GetAllIcodsaLoaEvent());
  }

  Future<void> _handleRefresh() async {
    _refreshCompleter = Completer<void>();
    await Future.delayed(Duration(seconds: 2));
    reloadAll();
    return _refreshCompleter!.future;
  }

  void clearAll() {
    paperIdController.clear();
    titleController.clear();
    conferenceTitleController.clear();
    timeController.clear();
    dateController.clear();
    placeController.clear();
    statusController.clear();
    signatureController.clear();
    signatures.clear();
    for (var controller in authorControllers) {
      controller.clear();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc.add(GetSignatureId());
      widget.roleId == 3
          ? _bloc.add(GetAllLoaEvent())
          : _bloc.add(GetAllIcodsaLoaEvent());
      _refreshKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bloc: _bloc,
      listener: (context, state) {
        if (state is SuccessLoaCreate) {
          clearAll();
          reloadAll();
          Navigator.of(context).pop();
          _refreshCompleter?.complete();
          return DisplayMessage.successMessage(state.message, context);
        }

        if (state is FailedState) {
          Navigator.of(context).pop();
          _refreshCompleter?.complete();
          state.message.map((item) {
            return DisplayMessage.errorMessage(item, context);
          }).toList();
        }
        if (state is SuccessSignatureState) {
          signatures.clear();
          for (var signature in state.data) {
            signatures.add(signature.id.toString());
          }
        }
        if (state is SuccessState) {
          setState(() {
            conferences.clear();
            final sortedUsers = List<LoaEntity>.from(state.data)
              ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

            for (var user in sortedUsers) {
              conferences.add(user);
            }

            _refreshCompleter?.complete();
          });
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
      appWidget: BlocBuilder<LoaBloc, LoaState>(
        builder: (context, state) {
          return RefreshIndicator(
            key: _refreshKey,
            onRefresh: _handleRefresh,
            color: AppColors.primary,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildHeader(widget.title),
                const SizedBox(height: 20),
                _buildTable("Peserta", conferences),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          text: "LoA \n${title}",
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
            : Center(child: AppText(text: "Please Wait.....")),
      ],
    );
  }

  List<DataColumn> _buildColumns() {
    return [
      _centeredColumn("Judul Paper"),
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

  DataRow _buildRow(LoaEntity conference) {
    return DataRow(
      cells: [
        DataCell(AppText(text: conference.paperTitle ?? "")),
        DataCell(AppText(text: conference.authorNames?.join(', ') ?? "")),
        DataCell(Center(
          child: AppText(
            text: conference.createdAt != null
                ? DateFormat('HH:mm').format(conference.createdAt!.toLocal())
                : "",
          ),
        )),
        DataCell(AppText(text: conference.tempatTanggal ?? "")),
        DataCell(AppText(text: conference.status ?? "")),
        DataCell(
          Row(
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
      ],
    );
  }

  void _showAddDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder<LoaBloc, LoaState>(
          bloc: _bloc,
          builder: (context, state) {
            final bool isLoading = state is LoadingState && state.isLoading;
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
              content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setStateDialog) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppTextfield(
                          prefixIcon: Icon(
                            Icons.pin_outlined,
                            color: AppColors.grayBackground3,
                          ),
                          hint: "Paper ID",
                          controller: paperIdController,
                        ),
                        AppTextfield(
                          prefixIcon: Icon(
                            Icons.title,
                            color: AppColors.grayBackground3,
                          ),
                          hint: "Judul Paper",
                          controller: titleController,
                        ),
                        AppTextfield(
                          prefixIcon: Icon(
                            Icons.title,
                            color: AppColors.grayBackground3,
                          ),
                          hint: "Judul Conference",
                          controller: conferenceTitleController,
                        ),
                        ...authorControllers.asMap().entries.map((entry) {
                          int index = entry.key;
                          TextEditingController controller = entry.value;
                          return Row(
                            children: [
                              Expanded(
                                child: AppTextfield(
                                  prefixIcon: Icon(
                                    Icons.person_outline,
                                    color: AppColors.grayBackground3,
                                  ),
                                  hint: "Penulis ${index + 1}",
                                  controller: controller,
                                  deleteTextfield: true,
                                  onDelete: () {
                                    if (authorControllers.length > 1) {
                                      setStateDialog(() {
                                        authorControllers.removeAt(index);
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            onPressed: () {
                              setStateDialog(() {
                                authorControllers.add(TextEditingController());
                              });
                            },
                            style: ButtonStyle(
                                splashFactory: NoSplash.splashFactory,
                                backgroundColor: WidgetStateProperty.all<Color>(
                                  Colors.transparent,
                                )),
                            icon: Icon(Icons.add),
                            label: Text("Tambah Penulis"),
                          ),
                        ),
                        AppTextfield(
                          prefixIcon: Icon(
                            Icons.calendar_today_outlined,
                            color: AppColors.grayBackground3,
                          ),
                          hint: "Tempat",
                          controller: placeController,
                        ),
                        AppDatePicker(
                          dateController: dateController,
                          hint: "Tanggal",
                          value: (value) {
                            dateController.text = value;
                          },
                        ),
                        AppDropdown(
                          label: "Accepted/Rejected",
                          items: ["Accepted", "Rejected"],
                          onChanged: (value) {
                            statusController.text = value ?? "Accepted";
                            print("Selected: $value");
                          },
                        ),
                        state is LoadingSignatureId && state.isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primary,
                                ),
                              )
                            : AppDropdown(
                                label: "Signature",
                                items: signatures,
                                onChanged: (value) {
                                  signatureController.text = value ?? "";
                                  print("Selected Signature ID: $value");
                                },
                              ),
                        // AppTextfield(
                        //   prefixIcon: Icon(Icons.fingerprint_outlined),
                        //   hint: "Signature ID",
                        //   controller: signatureController,
                        // ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: AppButton(
                            text: "Simpan LOA",
                            isLoading: isLoading,
                            action: () {
                              final signatureText =
                                  signatureController.text.trim();
                              List<String> authorNames = authorControllers
                                  .map((controller) => controller.text)
                                  .toList();
                              if (signatureText.isEmpty ||
                                  int.tryParse(signatureText) == null) {
                                Navigator.pop(context);
                                DisplayMessage.errorMessage(
                                    "Signature ID harus berupa angka!",
                                    context);
                                return;
                              }
                              widget.roleId == 3
                                  ? _bloc.add(
                                      CreateLoaEvent(
                                        paperIdController.text,
                                        titleController.text,
                                        authorNames,
                                        statusController.text,
                                        "${placeController.text},${dateController.text}",
                                        int.parse(signatureController.text),
                                      ),
                                    )
                                  : _bloc.add(
                                      CreateLoaIcodsa(
                                        paperIdController.text,
                                        titleController.text,
                                        authorNames,
                                        statusController.text,
                                        "${placeController.text},${dateController.text}",
                                        int.parse(signatureController.text),
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

  void _showDetailLoaIcicyta(LoaEntity detail) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white,
          title: AppText(
            text: "Detail LOA",
            fontSize: 21,
            fontWeight: FontWeight.w700,
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow("Judul Paper", detail.paperTitle ?? "-"),
                _buildDetailRow(
                    "Penulis", detail.authorNames?.join(', ') ?? ""),
                _buildDetailRow(
                    "Waktu",
                    detail.createdAt != null
                        ? DateFormat('HH:mm').format(detail.createdAt!)
                        : ""),
                _buildDetailRow(
                    "Tempat & Tanggal", detail.tempatTanggal ?? "-"),
                _buildDetailRow("Signature Id", detail.signatureId.toString()),
                _buildDetailRow("Status", detail.status ?? "-"),
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
