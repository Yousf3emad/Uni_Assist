import 'package:flutter/material.dart';

import '../app_colors.dart';

Widget createTable({
  required List<String> subjects,
  required String dataColumnLabel,
}) {
  List<DataColumn> columns = [
    DataColumn(
      label: Text(dataColumnLabel),
    )
  ];

  List<DataRow> rows = [];

  // Adding columns
  for (int i = 0; i < 6; i++) {
    columns.add(
      DataColumn(
        label: Text("${i + 1}"),
      ),
    );
  }

  // Adding rows
  for (int i = 0; i < subjects.length; i++) {
    List<DataCell> cells = [];
    cells.add(DataCell(Text(subjects[i]))); // Subject name cell
    for (int j = 0; j < 6; j++) {
      cells.add(DataCell(j % 2 == 0
          ? const Icon(Icons.check)
          : const Icon(Icons.clear))); // Data cells
    }
    rows.add(DataRow(cells: cells));
  }

  return DataTable(
      border: TableBorder.symmetric(
          outside: const BorderSide(),
          inside: const BorderSide(color: AppColors.drawerColor)),
      columns: columns,
      rows: rows);
}
