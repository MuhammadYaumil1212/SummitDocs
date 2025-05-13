import 'dart:async';

import 'package:SummitDocs/Domain/receipt/entity/receipt_entity.dart';
import 'package:SummitDocs/Presentations/dashboard_super_admin/widgets/dashboard_card.dart';
import 'package:SummitDocs/commons/widgets/app_scaffold.dart';
import 'package:SummitDocs/commons/widgets/app_text.dart';
import 'package:SummitDocs/commons/widgets/title.dart';
import 'package:SummitDocs/core/config/theme/app_colors.dart';
import 'package:SummitDocs/core/helper/message/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../Domain/home/entities/LoaEntity.dart';
import '../../../../Domain/home/entities/invoice_entity.dart';
import '../../bloc/icodsa/dashboard_icodsa_bloc.dart';

class DashboardIcodsaScreen extends StatefulWidget {
  const DashboardIcodsaScreen({super.key});

  @override
  State<DashboardIcodsaScreen> createState() => _DashboardIcodsaScreenState();
}

class _DashboardIcodsaScreenState extends State<DashboardIcodsaScreen> {
  final DashboardIcodsaBloc _bloc = DashboardIcodsaBloc();
  final ValueNotifier<bool> _isExpandedIcodsa = ValueNotifier(true);
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  Completer<void>? _refreshCompleter;
  final List<InvoiceEntity> conferences = [];
  final List<LoaEntityHome> conferenceLoa = [];
  final List<ReceiptEntity> conferenceReceipt = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc.add(GetHistoryLoAIcodsa());
      _bloc.add(GetHistoryInvoiceIcodsa());
      _bloc.add(GetHistoryReceiptIcodsa());
      _refreshKey.currentState?.show();
    });
  }

  void reloadAll() {
    setState(() {
      conferences.clear();
      conferenceReceipt.clear();
      conferenceLoa.clear();
    });
    _bloc.add(GetHistoryLoAIcodsa());
    _bloc.add(GetHistoryInvoiceIcodsa());
    _bloc.add(GetHistoryReceiptIcodsa());
  }

  Future<void> _handleRefresh() {
    _refreshCompleter = Completer<void>();
    _bloc.add(GetHistoryLoAIcodsa());
    _bloc.add(GetHistoryInvoiceIcodsa());
    _bloc.add(GetHistoryReceiptIcodsa());
    return _refreshCompleter!.future;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bloc: _bloc,
      listener: (BuildContext context, state) {
        if (state is SuccessTableInvoice) {
          setState(() {
            final sortedEntity = List<InvoiceEntity>.from(state.data)
              ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
            conferences
              ..clear()
              ..addAll(sortedEntity);
          });
          if (!(_refreshCompleter?.isCompleted ?? true)) {
            _refreshCompleter?.complete();
          }
        }

        if (state is FailedTableInvoice) {
          if (!(_refreshCompleter?.isCompleted ?? true)) {
            _refreshCompleter?.complete();
          }
          return DisplayMessage.errorMessage(state.message, context);
        }

        if (state is SuccessTableReceipt) {
          setState(() {
            final sortedEntity = List<ReceiptEntity>.from(state.data)
              ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
            conferenceReceipt
              ..clear()
              ..addAll(sortedEntity);
          });
          if (!(_refreshCompleter?.isCompleted ?? true)) {
            _refreshCompleter?.complete();
          }
        }

        if (state is FailedTableReceipt) {
          if (!(_refreshCompleter?.isCompleted ?? true)) {
            _refreshCompleter?.complete();
          }
          return DisplayMessage.errorMessage(state.message, context);
        }

        if (state is SuccessTableLoa) {
          setState(() {
            final sortedEntity = List<LoaEntityHome>.from(state.data)
              ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
            conferenceLoa
              ..clear()
              ..addAll(sortedEntity);
          });
          if (!(_refreshCompleter?.isCompleted ?? true)) {
            _refreshCompleter?.complete();
          }
        }

        if (state is FailedTableLoa) {
          if (!(_refreshCompleter?.isCompleted ?? true)) {
            _refreshCompleter?.complete();
          }
          return DisplayMessage.errorMessage(state.message, context);
        }
      },
      appWidget: BlocBuilder<DashboardIcodsaBloc, DashboardIcodsaState>(
        builder: (context, state) {
          return RefreshIndicator(
            key: _refreshKey,
            onRefresh: _handleRefresh,
            color: AppColors.primary,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HomeTitle(
                      title: "Selamat Datang",
                      description: "Di Dashboard ICODSA",
                    ),
                    _buildExpansionTile("ICODSA", _isExpandedIcodsa),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildExpansionTile(String title, ValueNotifier<bool> isExpanded) {
    return ValueListenableBuilder<bool>(
      valueListenable: isExpanded,
      builder: (context, expanded, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
          ),
          child: ExpansionTile(
            showTrailingIcon: false,
            onExpansionChanged: (value) => isExpanded.value = value,
            leading: Icon(
              expanded
                  ? Icons.arrow_drop_up_outlined
                  : Icons.arrow_drop_down_outlined,
              color: Colors.black,
            ),
            title: AppText(
              text: title,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
            initiallyExpanded: true,
            children: [
              DashboardCard(
                title: "History Invoice",
                historyItems: _mapHistoryInvoiceItems(),
              ),
              const SizedBox(height: 10),
              DashboardCard(
                title: "History LoA",
                historyItems: _mapHistoryLoaItems(),
              ),
              const SizedBox(height: 10),
              DashboardCard(
                title: "History Receipt",
                historyItems: _mapHistoryReceiptItems(),
              ),
            ],
          ),
        );
      },
    );
  }

  List<HistoryItem> _mapHistoryLoaItems() {
    if (conferenceLoa.isEmpty) {
      return [
        HistoryItem(
          text: "Belum ada data LoA",
          statusText: "-",
          status: false,
        ),
      ];
    }

    final sortedConferences = conferenceLoa
      ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    return sortedConferences.map((e) {
      final formattedDate = e.createdAt != null
          ? DateFormat('dd/MM/yyyy').format(e.createdAt!)
          : 'Unknown Date';

      return HistoryItem(
        text:
            "${e.paperId ?? 'No ID'} - ${e.paperTitle ?? 'Tidak ada Paper'} - $formattedDate",
        statusText: _mapStatusLoaText(e.status),
        status: e.status != 'Rejected',
      );
    }).toList();
  }

  List<HistoryItem> _mapHistoryReceiptItems() {
    if (conferenceReceipt.isEmpty) {
      return [
        HistoryItem(
          text: "Belum ada data receipt",
          statusText: "-",
          status: false,
        ),
      ];
    }

    final sortedConferences = conferenceReceipt
      ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    return sortedConferences.map((e) {
      final formattedDate = e.createdAt != null
          ? DateFormat('dd/MM/yyyy').format(e.createdAt!)
          : 'Unknown Date';

      return HistoryItem(
        text:
            "${e.paperId ?? 'No ID'} - ${e.paperTitle ?? 'Tidak ada judul'} - $formattedDate",
        statusText: "",
        status: "" != '',
        hideStatus: true,
      );
    }).toList();
  }

  List<HistoryItem> _mapHistoryInvoiceItems() {
    if (conferences.isEmpty) {
      return [
        HistoryItem(
          text: "Belum ada invoice",
          statusText: "-",
          status: false,
        ),
      ];
    }

    final sortedConferences = conferences
      ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    return sortedConferences.map((e) {
      final formattedDate = e.createdAt != null
          ? DateFormat('dd/MM/yyyy').format(e.createdAt!)
          : 'Unknown Date';

      return HistoryItem(
        text:
            "${e.invoiceNo ?? 'No ID'} - ${e.institution ?? 'Tidak ada institusi'} - $formattedDate",
        statusText: _mapStatusText(e.status),
        status: e.status != 'Pending',
        isPending: e.status == 'Pending',
      );
    }).toList();
  }

  String _mapStatusText(String? status) {
    switch (status) {
      case "Pending":
        return "Pending";
      case "Paid":
        return "Paid";
      case "Unpaid":
        return "Unpaid";
      default:
        return "Unknown";
    }
  }

  String _mapStatusLoaText(String? status) {
    switch (status) {
      case "Accepted":
        return "Accepted";
      case "Rejected":
        return "Rejected";
      default:
        return "Unknown";
    }
  }
}
