import 'package:flutter/material.dart';

import '../app_colors.dart';

Widget createTable({
  required List<String> subjects,
}) {
  List<DataColumn> columns = [
    DataColumn(
      label: Text("Subject name"),
    )
  ];

  List<DataRow> rows = [];

  // Adding columns
  for (int i = 0; i < 6; i++) {
    columns.add(DataColumn(label: Text("${i + 1}")));
  }

  // Adding rows
  for (int i = 0; i < subjects.length; i++) {
    List<DataCell> cells = [];
    cells.add(DataCell(Text(subjects[i]))); // Subject name cell
    for (int j = 0; j < 6; j++) {
      cells.add(DataCell(
          j % 2 == 0 ? Icon(Icons.check) : Icon(Icons.clear))); // Data cells
    }
    rows.add(DataRow(cells: cells));
  }

  return DataTable(
      border: TableBorder.symmetric(
          outside: BorderSide(),
          inside: BorderSide(color: AppColors.drawerColor)),
      columns: columns,
      rows: rows);
}
