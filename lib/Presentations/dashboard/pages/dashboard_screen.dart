import 'package:SummitDocs/Presentations/dashboard/widgets/dashboard_card.dart';
import 'package:SummitDocs/commons/widgets/app_text.dart';
import 'package:SummitDocs/commons/widgets/title.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isExpandedIcodsa = true;
  bool _isExpandedIcicyta = true;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeTitle(
              title: "Selamat Datang",
              description: "Di Dashboard",
            ),
            Theme(
              data: Theme.of(context).copyWith(
                splashFactory: NoSplash.splashFactory,
                highlightColor: Colors.transparent,
              ),
              child: ExpansionTile(
                showTrailingIcon: false,
                onExpansionChanged: (expanded) {
                  setState(() {
                    _isExpandedIcodsa = expanded;
                  });
                },
                leading: Icon(
                  _isExpandedIcodsa
                      ? Icons.arrow_drop_up_outlined
                      : Icons.arrow_drop_down_outlined,
                  color: Colors.black,
                ),
                title: AppText(
                  text: "ICODSA",
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
                  const SizedBox(height: 20),
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
            ),
            Theme(
              data: Theme.of(context).copyWith(
                splashFactory: NoSplash.splashFactory,
                highlightColor: Colors.transparent,
              ),
              child: ExpansionTile(
                showTrailingIcon: false,
                onExpansionChanged: (expanded) {
                  setState(() {
                    _isExpandedIcicyta = expanded;
                  });
                },
                leading: Icon(
                  _isExpandedIcicyta
                      ? Icons.arrow_drop_up_outlined
                      : Icons.arrow_drop_down_outlined,
                  color: Colors.black,
                ),
                title: AppText(
                  text: "ICICYTA",
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
                  const SizedBox(height: 20),
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
            ),
          ],
        ),
      ),
    );
  }
}
