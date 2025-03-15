import 'package:SummitDocs/Presentations/LoA/pages/files_loa_screen.dart';
import 'package:SummitDocs/Presentations/invoice/pages/files_invoice_screen.dart';
import 'package:SummitDocs/Presentations/receipt/pages/files_receipt_screen.dart';
import 'package:SummitDocs/commons/constants/string.dart';
import 'package:SummitDocs/commons/widgets/app_text.dart';
import 'package:SummitDocs/core/helper/message/message.dart';
import 'package:SummitDocs/core/helper/navigation/app_navigation.dart';
import 'package:flutter/material.dart';

import '../../../commons/widgets/title.dart';
import '../../error/error_screen.dart';
import '../widgets/feature_card.dart';
import 'FeatureItem.dart';

class FilesScreen extends StatelessWidget {
  final int roleId;
  const FilesScreen({super.key, required this.roleId});

  @override
  Widget build(BuildContext context) {
    final featuresIcodsa = [
      FeatureItem(id: 1, icon: AppString.loaIcon, text: "LoA"),
      FeatureItem(id: 2, icon: AppString.overviewIcon, text: "Invoice"),
      FeatureItem(id: 3, icon: AppString.receiptIcon, text: "Receipt"),
    ];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: roleId != 0
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeTitle(
                  title: "Berkas",
                  description: "Pilih Salah Satu",
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppText(
                    text: roleId == 2 ? "ICODSA" : "ICICYTA",
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: ListView.separated(
                    itemCount: featuresIcodsa.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, index) {
                      final feature = featuresIcodsa[index];
                      return Featurecard(
                        onClick: () {
                          switch (feature.id) {
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
                              DisplayMessage.errorMessage(
                                  "No Features", context);
                          }
                        },
                        icon: feature.icon,
                        text: feature.text,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(width: 35),
                  ),
                ),
              ],
            )
          : ErrorScreen(
              errorMessage: 'Role tidak sesuai',
              imageString: AppString.errorImages,
            ),
    );
  }
}
