import 'package:berkas_conference/commons/widgets/app_text.dart';
import 'package:flutter/material.dart';

class AppDataTable<T> extends StatelessWidget {
  final List<DataColumn> columns;
  final List<T> data;
  final DataRow Function(T) rowBuilder;
  final int rowsPerPage;

  const AppDataTable({
    super.key,
    required this.columns,
    required this.data,
    required this.rowBuilder,
    this.rowsPerPage = 5,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const double rowHeight = 56.0;
        const double headerHeight = 64.0;
        const double footerHeight = 56.0;
        final availableHeight =
            constraints.maxHeight - headerHeight - footerHeight;
        final int maxRowsPerPage = (availableHeight / rowHeight).floor();
        final int dynamicRowsPerPage =
            data.isEmpty ? 1 : data.length.clamp(1, maxRowsPerPage);

        return SizedBox(
          height: constraints.maxHeight,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: PaginatedDataTable(
              header: AppText(
                text: "LoA",
                fontWeight: FontWeight.w700,
                fontSize: 30,
              ),
              columnSpacing: MediaQuery.of(context).size.width * 0.32,
              showFirstLastButtons: false,
              columns: columns,
              source: _CustomDataTableSource<T>(data, rowBuilder),
              rowsPerPage: dynamicRowsPerPage, // Jumlah baris dinamis
            ),
          ),
        );
      },
    );
  }
}

class _CustomDataTableSource<T> extends DataTableSource {
  final List<T> data;
  final DataRow Function(T) rowBuilder;

  _CustomDataTableSource(this.data, this.rowBuilder);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    return rowBuilder(data[index]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
