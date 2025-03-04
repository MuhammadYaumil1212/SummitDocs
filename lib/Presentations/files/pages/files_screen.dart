import 'package:SummitDocs/commons/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../../../commons/widgets/title.dart';

class FilesScreen extends StatelessWidget {
  const FilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeTitle(
            title: "Berkas",
            description: "Pilih Salah Satu",
          )
        ],
      ),
    );
  }
}
