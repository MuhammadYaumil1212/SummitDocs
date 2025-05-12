import 'package:SummitDocs/Presentations/manage_account/pages/manage_account.dart';
import 'package:SummitDocs/Presentations/signature/pages/signature_screen.dart';
import 'package:SummitDocs/Presentations/transfer_virtual/pages/transfer_virtual.dart';
import 'package:flutter/material.dart';

import '../../../commons/constants/string.dart';
import '../../../commons/widgets/title.dart';
import '../../../core/helper/message/message.dart';
import '../../../core/helper/navigation/app_navigation.dart';
import '../../files/pages/FeatureItem.dart';
import '../../files/widgets/feature_card.dart';

class AdminBank extends StatelessWidget {
  final int roleId;
  const AdminBank({super.key, required this.roleId});

  @override
  Widget build(BuildContext context) {
    final List<FeatureItem> features = [
      FeatureItem(
        id: 1,
        icon: AppString.plusIcon,
        text: "Tambah Akun",
      ),
      FeatureItem(
        id: 2,
        icon: AppString.plusIcon,
        text: "Transfer / Virtual Account",
      ),
      FeatureItem(
        id: 3,
        icon: AppString.signatureIcon,
        text: "Signature",
      ),
    ];
    void _navigateToFeature(BuildContext context, int id, String title) {
      switch (id) {
        case 1:
          AppNavigator.push(
            context,
            const ManageAccount(),
          );
          break;
        case 2:
          AppNavigator.push(
            context,
            TransferVirtual(),
          );
          break;
        case 3:
          AppNavigator.push(
            context,
            SignatureScreen(),
          );
        default:
          DisplayMessage.errorMessage("No Features", context);
      }
    }

    Widget _buildFeatureList(BuildContext context, String title) {
      return SizedBox(
        width: double.infinity,
        child: GridView.builder(
          itemCount: features.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Ini bikin 2 kolom
            mainAxisSpacing: 20, // Jarak vertikal antar item
            crossAxisSpacing: 20, // Jarak horizontal antar item
            childAspectRatio: 1.5, // Atur rasio lebar:tinggi
          ),
          itemBuilder: (context, index) {
            final feature = features[index];
            return Featurecard(
              sizeWidthBox: 162,
              onClick: () => _navigateToFeature(context, feature.id, title),
              textSize: 13,
              icon: feature.icon,
              text: feature.text,
            );
          },
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeTitle(title: "Admin", description: "Pilih Salah Satu"),
          const SizedBox(height: 20),
          _buildFeatureList(context, "Admin"),
        ],
      ),
    );
  }
}
