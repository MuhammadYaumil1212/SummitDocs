import 'package:SummitDocs/Presentations/dashboard_super_admin/bloc/dashboard_bloc.dart';
import 'package:SummitDocs/Presentations/dashboard_super_admin/widgets/dashboard_card.dart';
import 'package:SummitDocs/commons/widgets/app_scaffold.dart';
import 'package:SummitDocs/commons/widgets/app_text.dart';
import 'package:SummitDocs/commons/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _bloc = DashboardBloc();
  final ValueNotifier<bool> _isExpandedIcodsa = ValueNotifier(true);

  final ValueNotifier<bool> _isExpandedIcicyta = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bloc: _bloc,
      listener: (BuildContext context, DashboardState state) {},
      appWidget: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeTitle(
                    title: "Selamat Datang",
                    description: "Di Dashboard Super Admin",
                  ),
                  _buildExpansionTile("ICODSA", _isExpandedIcodsa),
                  _buildExpansionTile("ICICYTA", _isExpandedIcicyta),
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
