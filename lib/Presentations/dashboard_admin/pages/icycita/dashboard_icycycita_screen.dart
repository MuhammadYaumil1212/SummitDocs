import 'dart:async';

import 'package:SummitDocs/Domain/home/entities/LoaEntity.dart';
import 'package:SummitDocs/Domain/home/entities/invoice_entity.dart';
import 'package:SummitDocs/Presentations/dashboard_super_admin/widgets/dashboard_card.dart';
import 'package:SummitDocs/Presentations/dashboard_admin/bloc/icycita/dashboard_icycita_bloc.dart';
import 'package:SummitDocs/commons/widgets/app_scaffold.dart';
import 'package:SummitDocs/commons/widgets/app_text.dart';
import 'package:SummitDocs/commons/widgets/title.dart';
import 'package:SummitDocs/core/config/theme/app_colors.dart';
import 'package:SummitDocs/core/helper/formatter/date_formatter.dart';
import 'package:SummitDocs/core/helper/message/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DashboardIcycitaScreen extends StatefulWidget {
  const DashboardIcycitaScreen({super.key});

  @override
  State<DashboardIcycitaScreen> createState() => _DashboardIcycitaScreenState();
}

class _DashboardIcycitaScreenState extends State<DashboardIcycitaScreen> {
  final DashboardIcycitaBloc _bloc = DashboardIcycitaBloc();
  final ValueNotifier<bool> _isExpandedIcodsa = ValueNotifier(true);
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  Completer<void>? _refreshCompleter;
  final List<InvoiceEntity> conferences = [];
  final List<LoaEntity> conferenceLoa = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc.add(GetHistoryInvoiceIcicyta());
      _bloc.add(GetHistoryLOAIcicyta());
      _refreshKey.currentState?.show();
    });
  }

  void reloadAll() {
    setState(() {
      conferences.clear();
    });
    _bloc.add(GetHistoryInvoiceIcicyta());
    _bloc.add(GetHistoryLOAIcicyta());
  }

  Future<void> _handleRefresh() {
    _refreshCompleter = Completer<void>();
    _bloc.add(GetHistoryInvoiceIcicyta());
    _bloc.add(GetHistoryLOAIcicyta());
    return _refreshCompleter!.future;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bloc: _bloc,
      listener: (BuildContext context, state) {
        if (state is SuccessTable) {
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

        if (state is SuccessTableLoa) {
          setState(() {
            print("data table loa : ${state.data.length}");
            final sortedEntity = List<LoaEntity>.from(state.data)
              ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

            conferenceLoa
              ..clear()
              ..addAll(sortedEntity);
          });
          if (!(_refreshCompleter?.isCompleted ?? true)) {
            _refreshCompleter?.complete();
          }
        }

        if (state is FailedTable) {
          DisplayMessage.errorMessage(state.message, context);
          if (!(_refreshCompleter?.isCompleted ?? true)) {
            _refreshCompleter?.complete();
          }
        }
        if (state is FailedTableLoa) {
          DisplayMessage.errorMessage(state.message, context);
          if (!(_refreshCompleter?.isCompleted ?? true)) {
            _refreshCompleter?.complete();
          }
        }
      },
      appWidget: BlocBuilder<DashboardIcycitaBloc, DashboardIcycitaState>(
        builder: (context, state) {
          return RefreshIndicator(
            key: _refreshKey,
            onRefresh: _handleRefresh,
            color: AppColors.primary,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HomeTitle(
                      title: "Selamat Datang",
                      description: "Di Dashboard ICYCITA",
                    ),
                    _buildExpansionTile("ICYCITA", _isExpandedIcodsa),
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

  List<HistoryItem> _mapHistoryInvoiceItems() {
    if (conferences.isEmpty) {
      return [
        HistoryItem(
          text: "Belum ada data invoice",
          statusText: "-",
          status: false,
        ),
      ];
    }

    final sortedConferences = List<InvoiceEntity>.from(conferences)
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
