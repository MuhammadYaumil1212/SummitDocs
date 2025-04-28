import 'package:SummitDocs/core/config/theme/app_colors.dart';
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

        final double availableHeight = constraints.maxHeight.isFinite
            ? constraints.maxHeight - headerHeight - footerHeight
            : 0;

        final int maxRowsPerPage = availableHeight.isFinite
            ? (availableHeight / rowHeight).floor().clamp(
                  data.length >= 5 ? 5 : data.length,
                  data.length,
                )
            : rowsPerPage;

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: PaginatedDataTable(
            headingRowColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                return AppColors.grayBackground2;
              },
            ),
            horizontalMargin: 20,
            showEmptyRows: false,
            showFirstLastButtons: false,
            columns: columns,
            source: _CustomDataTableSource<T>(data, rowBuilder),
            rowsPerPage: maxRowsPerPage,
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
