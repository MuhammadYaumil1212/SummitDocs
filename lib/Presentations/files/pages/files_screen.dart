import 'package:SummitDocs/Presentations/LoA/pages/files_loa_screen.dart';
import 'package:SummitDocs/Presentations/invoice/pages/files_invoice_screen.dart';
import 'package:SummitDocs/Presentations/receipt/pages/files_receipt_screen.dart';
import 'package:SummitDocs/commons/constants/string.dart';
import 'package:SummitDocs/commons/widgets/app_text.dart';
import 'package:SummitDocs/core/helper/message/message.dart';
import 'package:SummitDocs/core/helper/navigation/app_navigation.dart';
import 'package:flutter/material.dart';

import '../../../commons/widgets/title.dart';
import '../widgets/feature_card.dart';
import 'FeatureItem.dart';

class FilesScreen extends StatelessWidget {
  final int roleId;
  const FilesScreen({super.key, required this.roleId});

  static final List<FeatureItem> features = [
    FeatureItem(id: 1, icon: AppString.loaIcon, text: "LoA"),
    FeatureItem(id: 2, icon: AppString.overviewIcon, text: "Invoice"),
    FeatureItem(id: 3, icon: AppString.receiptIcon, text: "Receipt"),
  ];

  void _navigateToFeature(BuildContext context, int id) {
    switch (id) {
      case 1:
        AppNavigator.push(context, FilesLoaScreen());
        break;
      case 2:
        AppNavigator.push(context, FilesInvoiceScreen());
        break;
      case 3:
        AppNavigator.push(context, FilesReceiptScreen());
        break;
      default:
        DisplayMessage.errorMessage("No Features", context);
    }
  }

  Widget _buildFeatureList(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: ListView.separated(
        itemCount: features.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final feature = features[index];
          return Featurecard(
            onClick: () => _navigateToFeature(context, feature.id),
            icon: feature.icon,
            text: feature.text,
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 35),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isRole1 = roleId == 1;
    final titleText = isRole1 ? "ICODSA" : (roleId == 2 ? "ICODSA" : "ICICYTA");

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeTitle(title: "Berkas", description: "Pilih Salah Satu"),
          const SizedBox(height: 20),
          if (isRole1) ...[
            const Align(
              alignment: Alignment.centerLeft,
              child: AppText(
                  text: "ICODSA", fontWeight: FontWeight.w700, fontSize: 18),
            ),
            const SizedBox(height: 10),
            _buildFeatureList(context),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: AppText(
                  text: "ICICYTA", fontWeight: FontWeight.w700, fontSize: 18),
            ),
            const SizedBox(height: 10),
            _buildFeatureList(context),
          ] else ...[
            Align(
              alignment: Alignment.centerLeft,
              child: AppText(
                  text: titleText, fontWeight: FontWeight.w700, fontSize: 18),
            ),
            const SizedBox(height: 10),
            _buildFeatureList(context),
          ]
        ],
      ),
    );
  }
}
