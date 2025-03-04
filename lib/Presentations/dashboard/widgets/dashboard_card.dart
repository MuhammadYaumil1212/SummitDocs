import 'package:SummitDocs/Presentations/dashboard/widgets/status_file.dart';
import 'package:SummitDocs/commons/widgets/app_button.dart';
import 'package:SummitDocs/commons/widgets/app_text.dart';
import 'package:SummitDocs/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:SummitDocs/Presentations/dashboard/widgets/status_file.dart';
import 'package:SummitDocs/commons/widgets/app_button.dart';
import 'package:SummitDocs/commons/widgets/app_text.dart';
import 'package:SummitDocs/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DashboardCard extends StatefulWidget {
  final String title;
  final List<HistoryItem> historyItems;
  final int initialItemsToShow;

  const DashboardCard({
    super.key,
    required this.title,
    required this.historyItems,
    this.initialItemsToShow = 5,
  });

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  late int itemsToShow;

  @override
  void initState() {
    super.initState();
    itemsToShow = widget.initialItemsToShow;
  }

  void _toggleList() {
    setState(() {
      if (itemsToShow >= widget.historyItems.length) {
        itemsToShow = widget.initialItemsToShow; // Reset ke jumlah awal
      } else {
        itemsToShow = (itemsToShow + 5).clamp(0, widget.historyItems.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(
          color: AppColors.grayBackground,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: widget.title,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: itemsToShow,
              itemBuilder: (context, index) {
                return HistoryItemTile(item: widget.historyItems[index]);
              },
            ),
            const SizedBox(height: 8),
            if (widget.historyItems.length > widget.initialItemsToShow)
              AppButton(
                action: _toggleList,
                text: itemsToShow >= widget.historyItems.length
                    ? "Show Less"
                    : "View More",
                borderColor: AppColors.grayBackground2,
                backgroundColor: AppColors.secondaryBackground,
                fontColor: Colors.black,
              ),
          ],
        ),
      ),
    );
  }
}

class HistoryItem {
  final String text;
  final String statusText;
  final bool status;

  HistoryItem({
    required this.text,
    required this.statusText,
    required this.status,
  });
}

class HistoryItemTile extends StatelessWidget {
  final HistoryItem item;

  const HistoryItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: AppText(text: item.text),
      trailing: StatusFile(
        statusText: item.statusText,
        status: item.status,
      ),
    );
  }
}
