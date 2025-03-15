import 'package:SummitDocs/Presentations/dashboard_super_admin/widgets/dashboard_card.dart';
import 'package:SummitDocs/Presentations/dashboard_admin/bloc/icycita/dashboard_icycita_bloc.dart';
import 'package:SummitDocs/commons/widgets/app_scaffold.dart';
import 'package:SummitDocs/commons/widgets/app_text.dart';
import 'package:SummitDocs/commons/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardIcycitaScreen extends StatefulWidget {
  const DashboardIcycitaScreen({super.key});

  @override
  State<DashboardIcycitaScreen> createState() => _DashboardIcycitaScreenState();
}

class _DashboardIcycitaScreenState extends State<DashboardIcycitaScreen> {
  final DashboardIcycitaBloc _bloc = DashboardIcycitaBloc();
  final ValueNotifier<bool> _isExpandedIcodsa = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bloc: _bloc,
      listener: (BuildContext context, state) {},
      appWidget: BlocBuilder<DashboardIcycitaBloc, DashboardIcycitaState>(
        builder: (context, state) {
          return SingleChildScrollView(
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
                title: "History LoA",
                historyItems: List.generate(
                  50,
                  (index) => HistoryItem(
                    text: "00${index + 1} - Nama - 1/1/2025",
                    statusText: index % 4 == 0 ? "Rejected" : "Accepted",
                    status: index % 4 != 0,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              DashboardCard(
                title: "History Invoice",
                historyItems: List.generate(
                  10,
                  (index) => HistoryItem(
                    text: "00${index + 1} - Nama - 1/1/2025",
                    statusText: index % 4 == 0 ? "Rejected" : "Accepted",
                    status: index % 4 != 0,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
