import 'dart:async';
import 'dart:io';

import 'package:SummitDocs/Domain/LoA/entity/loa_entity.dart';
import 'package:SummitDocs/Domain/signature/entity/signature_entity.dart';
import 'package:SummitDocs/commons/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:SummitDocs/commons/widgets/app_button.dart';
import 'package:SummitDocs/commons/widgets/app_text.dart';
import 'package:SummitDocs/core/config/theme/app_colors.dart';
import 'package:SummitDocs/Presentations/LoA/bloc/loa_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show ByteData, rootBundle;

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
  TextEditingController themeConferenceController = TextEditingController();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  Completer<void>? _refreshCompleter;
  final List<LoaEntity> conferences = [];
  final List<SignatureEntity> signatures = [];

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
          signatures.addAll(state.data);
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
                action: () async {
                  await generateLoAICICYTADocument(conference: conference);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  PdfColor pdfColorFromFlutterColor(Color color) {
    return PdfColor.fromInt(color.value);
  }

  // Future<void> generateLoAICICYTA(LoaEntity conference) async {
  //   final pdf = pw.Document();
  //   pdf.addPage(
  //     pw.Page(
  //       pageFormat: PdfPageFormat.a4,
  //       margin: const pw.EdgeInsets.all(32),
  //       build: (pw.Context context) {
  //         return pw.Column(
  //           crossAxisAlignment: pw.CrossAxisAlignment.start,
  //           children: [
  //             // Header
  //             pw.Container(
  //               width: double.infinity,
  //               decoration: pw.BoxDecoration(
  //                 color: pdfColorFromFlutterColor(AppColors.purpleIcicytaHex),
  //                 borderRadius: pw.BorderRadius.circular(8),
  //               ),
  //               child: pw.Padding(
  //                 padding: pw.EdgeInsets.all(15),
  //                 child: pw.Column(
  //                   crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                   children: [
  //                     pw.Text(
  //                       "ICICYTA 2024",
  //                       style: pw.TextStyle(
  //                         fontSize: 20,
  //                         fontWeight: pw.FontWeight.bold,
  //                         color: PdfColors.white,
  //                       ),
  //                     ),
  //                     pw.SizedBox(height: 20),
  //                     pw.Text(
  //                       "The 4th International Conference on Intelligent Cybernetics Technology & Applications 2024 (ICICyTA)",
  //                       style: pw.TextStyle(
  //                         fontSize: 20,
  //                         fontWeight: pw.FontWeight.bold,
  //                         color: PdfColors.white,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             pw.SizedBox(height: 20),
  //             // Judul
  //             pw.Text(
  //               'LETTER OF ACCEPTANCE',
  //               style: pw.TextStyle(
  //                 fontSize: 18,
  //                 fontWeight: pw.FontWeight.bold,
  //               ),
  //             ),
  //             pw.SizedBox(height: 24),
  //             // Isi
  //             pw.Text(
  //               "The 4th International Conference on Intelligent Cybernetics Technology & Applications 2024 (ICICyTA)",
  //               style: pw.TextStyle(fontSize: 12),
  //             ),
  //             pw.SizedBox(height: 25),
  //             pw.Text(
  //               "Dear, ${conference.authorNames?.join(', ') ?? ""}",
  //               style: pw.TextStyle(fontSize: 12),
  //             ),
  //             pw.SizedBox(height: 25),
  //             pw.Text(
  //               "Organizing & Program Committee is pleased to announce that your paper :",
  //               style: pw.TextStyle(fontSize: 12),
  //             ),
  //             pw.Text(
  //               conference.paperTitle ?? "-",
  //               style: pw.TextStyle(
  //                 fontSize: 12,
  //                 fontWeight: pw.FontWeight.bold,
  //               ),
  //             ),
  //             pw.SizedBox(height: 15),
  //             pw.Row(children: [
  //               pw.Text(
  //                 "Was",
  //                 style: pw.TextStyle(fontSize: 12),
  //               ),
  //               pw.SizedBox(width: 5),
  //               pw.Text(
  //                 "Accepted",
  //                 style: pw.TextStyle(
  //                   fontSize: 12,
  //                   fontWeight: pw.FontWeight.bold,
  //                 ),
  //               ),
  //               pw.SizedBox(height: 10),
  //               pw.Column(
  //                 crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                 children: [
  //                   pw.Text(
  //                     "For The 4ᵗʰ International Conference on Intelligent Cybernetics Technology &",
  //                     style: pw.TextStyle(
  //                       fontSize: 12,
  //                       fontWeight: pw.FontWeight.bold,
  //                     ),
  //                   ),
  //                   pw.Text(
  //                     "Applications 2024 (ICICyTA). For finishing your registration please follow the instruction,",
  //                     style: pw.TextStyle(
  //                       fontSize: 12,
  //                       fontWeight: pw.FontWeight.bold,
  //                     ),
  //                   ),
  //                   pw.Text(
  //                     "which has been already send by e-mail to all authors of accepted papers.",
  //                     style: pw.TextStyle(
  //                       fontSize: 12,
  //                       fontWeight: pw.FontWeight.bold,
  //                     ),
  //                   ),
  //                   pw.SizedBox(height: 12),
  //                   pw.Text(
  //                     "The 4ᵗʰ International Conference on Intelligent Cybernetics Technology &",
  //                     style: pw.TextStyle(
  //                       fontSize: 12,
  //                       fontWeight: pw.FontWeight.bold,
  //                     ),
  //                   ),
  //                   pw.Text(
  //                     'Applications 2024 (ICICyTA 2024) with theme "From Data to Decisions: Cybernetics and',
  //                     style: pw.TextStyle(
  //                       fontSize: 12,
  //                       fontWeight: pw.FontWeight.bold,
  //                     ),
  //                   ),
  //                   pw.Text(
  //                     'Intelligent Systems in Healthcare, IoT, and Business" will be held on December',
  //                     style: pw.TextStyle(
  //                       fontSize: 12,
  //                       fontWeight: pw.FontWeight.bold,
  //                     ),
  //                   ),
  //                   pw.Text(
  //                     '17-19, 2024 at Bali Indonesia.',
  //                     style: pw.TextStyle(
  //                       fontSize: 12,
  //                       fontWeight: pw.FontWeight.bold,
  //                     ),
  //                   ),
  //                 ],
  //               )
  //             ])
  //           ],
  //         );
  //       },
  //     ),
  //   );
  //
  //   // Menyimpan file PDF
  //   final output = await getTemporaryDirectory();
  //   final file = File("${output.path}/LoA_ICICYTA.pdf");
  //   await file.writeAsBytes(await pdf.save());
  //
  //   // Membuka file PDF
  //   await OpenFile.open(file.path);
  // }

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
                        AppTextfield(
                          prefixIcon: Icon(
                            Icons.title,
                            color: AppColors.grayBackground3,
                          ),
                          hint: "Tema Conference",
                          controller: themeConferenceController,
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
                                itemAsString: (signature) =>
                                    signature.namaPenandatangan ?? "",
                                onChanged: (selectedSignature) {
                                  if (selectedSignature is SignatureEntity) {
                                    for (var selected in signatures) {
                                      signatureController.text =
                                          selected.id.toString();
                                      print(
                                        "Selected Signature ID: ${selected.id}",
                                      );
                                    }
                                  }
                                },
                              ),
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
                                        themeConferenceController.text,
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
                                        themeConferenceController.text,
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

  Future<void> generateLoAICICYTADocument(
      {required LoaEntity conference}) async {
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

    final String displayPlaceDate = conference.tempatTanggal ??
        DateFormat('MMMM dd, yyyy').format(currentDate);

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

    final authorName = conference.authorNames;
    final formattedAuthorNames = formatAuthorNames(authorName);

    pdf.addPage(widget.roleId == 3
        ? pw.Page(
            pageFormat: PdfPageFormat.a4,
            margin: pw.EdgeInsets.zero,
            build: (pw.Context context) {
              return pw.Column(children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // Header
                    pw.Align(
                      alignment: pw.Alignment.bottomCenter,
                      child: pw.Container(
                          width: double.infinity,
                          color:
                              pdfColorFromFlutterColor(const Color(0xFF9461AF)),
                          padding: const pw.EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 12,
                          ),
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  'ICICYTA $currentYear',
                                  style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold,
                                    color:
                                        pdfColorFromFlutterColor(Colors.white),
                                  ),
                                ),
                                pw.Text(
                                  'The ${getOrdinal(editionNumber)} International Conference on Data Science and Its Applications $currentYear',
                                  style: pw.TextStyle(
                                    fontSize: 9,
                                    fontWeight: pw.FontWeight.bold,
                                    color:
                                        pdfColorFromFlutterColor(Colors.white),
                                  ),
                                ),
                              ])),
                    ),
                    // Content Wrapper
                    pw.Center(
                      child: pw.Container(
                        margin: const pw.EdgeInsets.symmetric(horizontal: 20),
                        padding: const pw.EdgeInsets.only(top: 20),
                        constraints: const pw.BoxConstraints(maxWidth: 650),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            // Letter of Acceptance Title & Subtitle
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  'LETTER OF ACCEPTANCE',
                                  style: pw.TextStyle(
                                    fontSize: 12,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.SizedBox(height: 20),
                                pw.Text(
                                  'The ${getOrdinal(editionNumber)} International Conference on Intelligent Cybernetics Technology & Application $currentYear (ICIyTA)',
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    color: pdfColorFromFlutterColor(
                                        const Color(0xFF000000)),
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(height: 20),

                            // Dear Author(s)
                            pw.Text(
                              'Dear ${formattedAuthorNames},',
                              style: pw.TextStyle(
                                fontSize: 10,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(height: 10),
                            // Paper Details
                            pw.Text(
                              'Organizing & Program Committee is pleased to announce that your paper:',
                              style: pw.TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            pw.SizedBox(height: 3),
                            pw.Text(
                              '${conference.paperTitle}',
                              style: pw.TextStyle(
                                fontSize: 10,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(height: 10),

                            // Was Accepted/Rejected
                            pw.Row(children: [
                              pw.Text(
                                'Was',
                                style: pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              pw.SizedBox(width: 5),
                              pw.Text(
                                conference.status ?? "",
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ]),
                            pw.SizedBox(height: 10),

                            // Additional Information
                            pw.Text(
                              'For The ${getOrdinal(editionNumber)} International Conference on Data Science and Its Applications $currentYear (ICICyTA $currentYear). For finishing your registration please follow the instruction, which has been already send by e-mail to all authors of accepted papers.',
                              style: pw.TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            pw.SizedBox(height: 10),
                            pw.Text(
                              'The ${getOrdinal(editionNumber)} International Conference on Data Science and Its Applications $currentYear (ICICyTA $currentYear) with theme "Data for Good: Leveraging Data Science for Social Impact" will be held on July 10-11, $currentYear at Aston Kuta Hotel & Residence, Bali, Indonesia.',
                              style: pw.TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            pw.SizedBox(height: 50),
                            // Signature Section
                            pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Column(
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Text(
                                    displayPlaceDate,
                                    style: pw.TextStyle(
                                      fontSize: 9,
                                    ),
                                  ),
                                  pw.Container(
                                    width: 120,
                                    height: 50,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border(
                                        bottom: pw.BorderSide(
                                          color: pdfColorFromFlutterColor(
                                              Colors.black),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: pw.Center(
                                      child: pw.Padding(
                                        padding: pw.EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        child: pw.Transform.rotate(
                                          angle: 0.2,
                                          child: pw.Text(
                                            'ICIyTA',
                                            style: pw.TextStyle(
                                              fontSize: 14,
                                              fontWeight: pw.FontWeight.bold,
                                              color: pdfColorFromFlutterColor(
                                                  const Color(0xFF9461AF)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  pw.SizedBox(height: 10),
                                  pw.Text(
                                    'Dr. Putu Harry Gunawan',
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                  pw.SizedBox(height: 5),
                                  pw.Text(
                                    'General Chair ICICyTA $currentYear',
                                    style: pw.TextStyle(
                                      fontSize: 9,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Spacer(),
                // Footer
                pw.Container(
                  color: pdfColorFromFlutterColor(const Color(0xFF9461AF)),
                  child: pw.Padding(
                    padding: pw.EdgeInsets.all(20),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Text(
                          "",
                          style: pw.TextStyle(fontSize: 20),
                        ),
                        pw.Image(teluLogo, height: 75),
                        pw.SizedBox(width: 8),
                        pw.Image(unbiLogo, height: 75),
                        pw.SizedBox(width: 8),
                        pw.Image(utmLogo, height: 30),
                      ],
                    ),
                  ),
                ),
              ]);
            },
          )
        : pw.Page(
            pageFormat: PdfPageFormat.a4,
            margin: pw.EdgeInsets.zero,
            build: (pw.Context context) {
              return pw.Column(children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // Header
                    pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Container(
                        width: double.infinity,
                        color: pdfColorFromFlutterColor(
                          const Color(0xff84D2DB),
                        ),
                        padding: const pw.EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 12,
                        ),
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Image(icodsaLogo, height: 35),
                                  pw.SizedBox(height: 15),
                                  pw.Text(
                                    'The ${getOrdinal(editionNumber)} International Conference on Data Science and Its Applications \n$currentYear (ICoDSA $currentYear)',
                                    style: pw.TextStyle(
                                      fontSize: 9,
                                      fontWeight: pw.FontWeight.bold,
                                      color: pdfColorFromFlutterColor(
                                          Colors.white),
                                    ),
                                  ),
                                ]),
                            pw.SizedBox(width: 50),
                            pw.Image(teluLogo, height: 75),
                            pw.SizedBox(width: 8),
                            pw.Image(unbiLogo, height: 35),
                            pw.SizedBox(width: 8),
                            pw.Image(utmLogo, height: 20),
                          ],
                        ),
                      ),
                    ),
                    pw.SizedBox(height: 30),
                    // Content Wrapper
                    pw.Center(
                      child: pw.Container(
                        margin: const pw.EdgeInsets.symmetric(horizontal: 20),
                        padding: const pw.EdgeInsets.only(top: 20),
                        constraints: const pw.BoxConstraints(maxWidth: 650),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            // Letter of Acceptance Title & Subtitle
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  'LETTER OF ACCEPTANCE',
                                  style: pw.TextStyle(
                                    fontSize: 12,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.SizedBox(height: 20),
                                pw.Text(
                                  'The ${getOrdinal(editionNumber)} International Conference on Data Science and Its Applications $currentYear (ICoDSA $currentYear)',
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    color: pdfColorFromFlutterColor(
                                        const Color(0xFF000000)),
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(height: 20),

                            // Dear Author(s)
                            pw.Text(
                              conference.authorNames!.length > 1
                                  ? 'Dear, \n${formattedAuthorNames}'
                                  : 'Dear,  $formattedAuthorNames',
                              style: pw.TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            pw.SizedBox(height: 10),
                            // Paper Details
                            pw.Text(
                              'Organizing & Program Committee is pleased to announce that your paper:',
                              style: pw.TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            pw.SizedBox(height: 3),
                            pw.Text(
                              '${conference.paperTitle}',
                              style: pw.TextStyle(
                                fontSize: 10,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(height: 10),

                            // Was Accepted/Rejected
                            pw.Row(children: [
                              pw.Text(
                                'Was',
                                style: pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              pw.SizedBox(width: 5),
                              pw.Text(
                                conference.status ?? "",
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ]),
                            pw.SizedBox(height: 50),

                            // Additional Information
                            pw.Text(
                              'For The ${getOrdinal(editionNumber)} International Conference on Data Science and Its Applications $currentYear (ICoDSA $currentYear). For finishing your registration please follow the instruction, which has been already send by e-mail to all authors of accepted papers.',
                              style: pw.TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            pw.SizedBox(height: 10),
                            pw.Text(
                              'The ${getOrdinal(editionNumber)} International Conference on Data Science and Its Applications $currentYear (ICoDSA $currentYear) with theme "${conference.paperTitle}" will be held on ${conference.tempatTanggal!.split(',').last}, $currentYear at ${conference.tempatTanggal!.split(',').first}, Indonesia.',
                              style: pw.TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            pw.SizedBox(height: 50),
                            // Signature Section
                            pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Stack(
                                alignment: pw.Alignment.bottomCenter,
                                children: [
                                  // Konten tanda tangan
                                  pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.center,
                                    children: [
                                      pw.Text(
                                        displayPlaceDate,
                                        style: pw.TextStyle(
                                          fontSize: 9,
                                        ),
                                      ),
                                      pw.SizedBox(height: 30),
                                      pw.Container(
                                        width: 120,
                                        height: 50,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border(
                                            bottom: pw.BorderSide(
                                              color: pdfColorFromFlutterColor(
                                                  Colors.black),
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        child: pw.Center(
                                          child: pw.Transform.rotate(
                                            angle: 0.2,
                                            child: pw.Text(
                                              'ICoDSA',
                                              style: pw.TextStyle(
                                                fontSize: 14,
                                                fontWeight: pw.FontWeight.bold,
                                                color: pdfColorFromFlutterColor(
                                                  const Color(0xFF003366),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      pw.SizedBox(height: 10),
                                      pw.Text(
                                        'Dr. Putu Harry Gunawan',
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 10,
                                        ),
                                      ),
                                      pw.SizedBox(height: 5),
                                      pw.Text(
                                        'General Chair ICoDSA $currentYear',
                                        style: pw.TextStyle(
                                          fontSize: 9,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Spacer(),
                // Footer
                pw.Container(
                  width: double.infinity,
                  color: pdfColorFromFlutterColor(
                    const Color(0xff84D2DB),
                  ),
                  child: pw.Padding(
                      padding: pw.EdgeInsets.all(20),
                      child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Text(
                              'The ${getOrdinal(editionNumber)} International Conference on Data Science and Its Applications $currentYear',
                              style: pw.TextStyle(
                                fontSize: 9,
                                fontWeight: pw.FontWeight.bold,
                                color: pdfColorFromFlutterColor(Colors.white),
                              ),
                            ),
                          ])),
                ),
              ]);
            }));

    // Save the PDF
    final directory = await getApplicationDocumentsDirectory();
    final file = File(
        '${directory.path}/LoA_${widget.roleId == 3 ? "ICICYTA" : "ICODSA"}_${conference.paperId}.pdf');
    await file.writeAsBytes(await pdf.save());

    // Open the PDF
    OpenFile.open(file.path);
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
