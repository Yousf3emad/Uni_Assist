import 'package:flutter/material.dart';
import '../../models/attendence/prof_ttendanceModel.dart';
import '../../shared/remote/api_manager.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  late Future<List<ProfAttendanceModel>> futureAttendance;

  @override
  void initState() {
    super.initState();
    futureAttendance = ApiManager.fetchProfAttendance("HCI");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProfAttendanceModel>>(
      future: futureAttendance,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          if(snapshot.data==null){
            return const Center(child: Text('No Attendance Yet.'));
        }
          // print("Error => ${snapshot.error}");
          // print("Data => ${snapshot.data}");
          else {
            return snapshot.hasError
              ? Center(child: Text('Error: ${snapshot.error}'))
              : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Subject')),
                        DataColumn(label: Text('Type')),
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Week 1')),
                        DataColumn(label: Text('Week 2')),
                        DataColumn(label: Text('Week 3')),
                        DataColumn(label: Text('Week 4')),
                        DataColumn(label: Text('Week 5')),
                        DataColumn(label: Text('Week 6')),
                        DataColumn(label: Text('Week 7')),
                        DataColumn(label: Text('Total')),
                      ],
                      rows: const [
                        DataRow(cells: [
                          DataCell(Text("attendance.subject")),
                          DataCell(Text("attendance.type")),
                          DataCell(Text("attendance.name")),
                          DataCell(Text("attendance.week1")),
                          DataCell(Text("attendance.week2")),
                          DataCell(Text("attendance.week3")),
                          DataCell(Text("attendance.week4")),
                          DataCell(Text("attendance.week5")),
                          DataCell(Text("attendance.week6")),
                          DataCell(Text("attendance.week7")),
                          DataCell(Text("attendance.total.toString()"))
                        ]),
                      ],
                    ),
                  ),
                );
          }
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Subject')),
                  DataColumn(label: Text('Type')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Week 1')),
                  DataColumn(label: Text('Week 2')),
                  DataColumn(label: Text('Week 3')),
                  DataColumn(label: Text('Week 4')),
                  DataColumn(label: Text('Week 5')),
                  DataColumn(label: Text('Week 6')),
                  DataColumn(label: Text('Week 7')),
                  DataColumn(label: Text('Total')),
                ],
                rows: snapshot.data!.map((attendance) {
                  return DataRow(cells: [
                    DataCell(Text(attendance.subject)),
                    DataCell(Text(attendance.type)),
                    DataCell(Text(attendance.name)),
                    DataCell(Text(attendance.week1)),
                    DataCell(Text(attendance.week2)),
                    DataCell(Text(attendance.week3)),
                    DataCell(Text(attendance.week4)),
                    DataCell(Text(attendance.week5)),
                    DataCell(Text(attendance.week6)),
                    DataCell(Text(attendance.week7)),
                    DataCell(Text(attendance.total.toString())),
                  ]);
                }).toList(),
              ),
            ),
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
