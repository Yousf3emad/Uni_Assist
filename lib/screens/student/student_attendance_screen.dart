import 'package:flutter/material.dart';
import 'package:uni_assest/consts/app_colors.dart';
import 'package:uni_assest/shared/remote/api_manager.dart';

import '../../models/attendence/student_attendance_model.dart';

class StudentAttendanceScreen extends StatefulWidget {
  const StudentAttendanceScreen({super.key});

  static String routeName = "StudentAttendanceScreen";

  @override
  State<StudentAttendanceScreen> createState() => _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {

  late Future<List<StudentAttendanceModel>> futureAttendance;

  @override
  void initState() {
    super.initState();
    futureAttendance =  ApiManager.fetchStudentAttendance();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder<List<StudentAttendanceModel>>(
        future: futureAttendance,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColors.drawerColor,),);
          } else if (snapshot.hasError) {
            print("ERRROOORRR ====>> ${snapshot.data}");
            print("ERRROOORRR ====>> ${snapshot.error}");
            //return Center(child: Text('Error: ${snapshot.error}'));
            return const Center(child: Text('Didn\'t Attend Any Lecture '));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 20.0, // Adjust as needed
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
                    return DataRow(
                      cells: [
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
                      ],
                    );
                  }).toList(),
                ),
              ),
            );
          } else {
            return const Text('No data available');
          }
        },
      ),
    );
  }

  Widget _buildWeekStatus(String week, String status) {
    return Expanded(
      child: Column(
        children: [
          Text(week),
          const SizedBox(height: 5),
          Text(status, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

}


