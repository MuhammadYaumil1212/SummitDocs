import 'package:SummitDocs/Presentations/LoA/pages/files_loa_screen.dart';
import 'package:SummitDocs/Presentations/files/pages/FeatureItem.dart';
import 'package:SummitDocs/Presentations/files/widgets/feature_card.dart';
import 'package:SummitDocs/commons/constants/string.dart';
import 'package:SummitDocs/commons/widgets/app_text.dart';
import 'package:SummitDocs/core/helper/navigation/app_navigation.dart';
import 'package:flutter/material.dart';

import '../../../commons/widgets/title.dart';

class FilesScreen extends StatelessWidget {
  const FilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final featuresIcodsa = [
      FeatureItem(id: 1, icon: AppString.loaIcon, text: "LoA"),
      FeatureItem(id: 2, icon: AppString.overviewIcon, text: "Invoice"),
      FeatureItem(id: 3, icon: AppString.receiptIcon, text: "Receipt"),
    ];
    final featuresIcycita = [
      FeatureItem(id: 4, icon: AppString.loaIcon, text: "LoA"),
      FeatureItem(id: 5, icon: AppString.overviewIcon, text: "Invoice"),
      FeatureItem(id: 6, icon: AppString.receiptIcon, text: "Receipt"),
    ];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
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
              text: "ICODSA",
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
                    AppNavigator.push(context, FilesLoaScreen());
                  },
                  icon: feature.icon,
                  text: feature.text,
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(width: 35),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: AppText(
              text: "ICICYTA",
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 100,
            width: double.infinity,
            child: ListView.separated(
              itemCount: featuresIcycita.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, index) {
                final feature = featuresIcycita[index];
                return Featurecard(
                  onClick: () {
                    AppNavigator.push(context, FilesLoaScreen());
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
      ),
    );
  }
}
