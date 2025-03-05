import 'package:SummitDocs/Presentations/LoA/bloc/loa_bloc.dart';
import 'package:SummitDocs/Presentations/LoA/pages/loa_entity.dart';
import 'package:SummitDocs/commons/widgets/app_button.dart';
import 'package:SummitDocs/commons/widgets/app_datatable.dart';
import 'package:SummitDocs/commons/widgets/app_scaffold.dart';
import 'package:SummitDocs/commons/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../../../commons/constants/string.dart';
import '../../../core/config/theme/app_colors.dart';

class FilesLoaScreen extends StatefulWidget {
  const FilesLoaScreen({super.key});

  @override
  State<FilesLoaScreen> createState() => _FilesLoaScreenState();
}

class _FilesLoaScreenState extends State<FilesLoaScreen> {
  final LoaBloc _bloc = LoaBloc();
  final List<LOAEntity> conferences = List.generate(
    15,
    (index) => LOAEntity(
      index + 1,
      "title",
      "ConferenceTitle",
      "John Doe",
      "10:00",
      "Bandung, Coblong",
      "Accepted",
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bloc: _bloc,
      listener: (context, state) {},
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Image.asset(AppString.logoApp),
        backgroundColor: AppColors.background,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(color: AppColors.grayBackground, height: 4.0),
        ),
      ),
      appWidget: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildTable("Peserta"),
              _buildTable("Pengurus"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTable(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: title,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 5),
        AppDataTable(
          columns: _buildColumns(),
          data: conferences,
          rowBuilder: _buildRow,
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const AppText(
          text: "LoA ICODSA",
          fontWeight: FontWeight.w700,
          fontSize: 30,
        ),
        AppButton(
          text: "Tambah Data",
          action: () {},
        ),
      ],
    );
  }

  List<DataColumn> _buildColumns() {
    return [
      _centeredColumn("Paper ID"),
      _centeredColumn("Judul Paper"),
      _centeredColumn("Judul Conference"),
      _centeredColumn("Penulis"),
      _centeredColumn("Waktu"),
      _centeredColumn("Tanggal dan Tempat"),
      _centeredColumn("Status"),
      _centeredColumn("Tindakan"),
    ];
  }

  DataColumn _centeredColumn(String title) {
    return DataColumn(
      label: Center(
        child: AppText(text: title),
      ),
    );
  }

  DataRow _buildRow(LOAEntity conference) {
    return DataRow(
      cells: [
        DataCell(Center(child: AppText(text: conference.paperId.toString()))),
        DataCell(Center(child: AppText(text: conference.paperTitle))),
        DataCell(Center(child: AppText(text: conference.conferenceTitle))),
        DataCell(Center(child: AppText(text: conference.writer))),
        DataCell(Center(child: AppText(text: conference.time))),
        DataCell(Center(child: AppText(text: conference.dateAndPlace))),
        DataCell(Center(child: AppText(text: conference.status))),
        DataCell(
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionButton(icon: AppString.infoIcon, action: () {}),
                const SizedBox(width: 10),
                ActionButton(icon: AppString.downloadIcon, action: () {}),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
